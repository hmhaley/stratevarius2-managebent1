class Organization < ActiveRecord::Base
extend ::Geocoder::Model::ActiveRecord

	# validates_presence_of :sector_type
	# validates_presence_of :web_url
	# validates_presence_of :hq_address_city
	# validates_presence_of :hq_address_state
	# validates_presence_of :hq_address_zip
	# validates_presence_of :hq_telephone

	# validates_format_of :hq_email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
	# validates_length_of :hq_email, maximum: 255

#Executive Relationships with Organizations, joined by table "relationships"
	has_many :relationships
	has_many :executives, through: :relationships
	accepts_nested_attributes_for :relationships, allow_destroy: true

#Sets up self-referential/loop many-to-many relationships/joins between two Organizations (both of whom are in the same model/table), through a join table called "Associations"; orgs could have an association because one wants to "follow" another or one wants to log a deal with another, or one wants to log another as a client or vendor, etc.  Need to put al of those choices of what type of association they have in another table
	has_many :initiators, class_name: "Association",
	  foreign_key: :initiator_id, inverse_of: :initiator
	has_many :receivers, class_name: "Association",
	  foreign_key: :receiver_id, inverse_of: :receiver

# GeoCoder at work 
	geocoded_by :full_address
  	after_validation :geocode

  	def full_address
    	return "#{hq_address_street}, #{hq_address_city}, #{hq_address_state}, #{hq_address_zip}"
  	end

	def geo_center
	    @organizations = Organization.all 
	    	@organizations.each do |d|
	      		coords.push(d.full_address.coordinates)
	      		Geocoder::Calculations.geographic_center(coords)
	    	end
	end

#Deal associations, joined by table "deals",  new words or variables I don't know if are yet defined: accepted_deals, deal_status, deal_status_id, pending_deals, initiator, deals_initiated_by_me, deals_not_initiated_by_me, occurances_as_partner (same as occurances_as_friend) 

    has_many :deals, :class_name => "Deal", :foreign_key => "organization_id"
    has_many :accepted_deals, -> { where('deal_status_id = ?', 2) }, :class_name => "Deal"
    has_many :pending_deals, -> { where('initiator = ? AND deal_status_id = ?', false, 1) }, :class_name => "Deal"
    has_many :deals_initiated_by_me, -> { where('initiator = ?', true) }, :class_name => "Deal", :foreign_key => "organization_id"
    has_many :deals_not_initiated_by_me, -> { where('initiator = ?', false) }, :class_name => "Deal", :foreign_key => "organization_id"
    has_many :occurances_as_partner, :class_name => "Deal", :foreign_key => "partner_id"

	def self.get_org_associations(org_name)
 		Organization.find_by_sql(["
 			SELECT 
	 			rorg_name, 
	 			rorg_types_id, 
	 			rassoc_type, 
	 			rexec_firstname, 
	 			rexec_lastName, 
	 			'Above Initiated' as \"initiator_or_receiver\" 
	 		FROM 
	 			(
	 			SELECT 
	 				r.org_name as rorg_name, 
	 				r.org_types_id as rorg_types_id, 
	 				i.org_name as iorg_name, 
	 				i.org_types_id as iorg_types_id, 
	 				a.assoc_type as rassoc_type, 
	 				e.firstname as rexec_firstname, 
	 				e.lastname as rexec_lastname 
	 			FROM 
				executives as e
				INNER JOIN
				relationships as l
				ON 
				e.id = l.executive_id
				RIGHT OUTER JOIN
	 			organizations AS r 
	 			ON 
				l.organization_id = r.id 
	 			INNER JOIN
	 			associations AS a 
	 			ON 
	 			r.id = a.receiver_id 
	 			INNER JOIN 
	 			organizations AS i 
	 			ON 
	 			a.initiator_id = i.id 
	 			WHERE 
	 			i.org_name = ? 
	 			OR 
	 			r.org_name = ?
	 			) 
 			AS associations 
 			WHERE 
 			rorg_name != ? 
 	    UNION
 			SELECT
 				iorg_name, 
 				iorg_types_id, 
 				iassoc_type, 
 				iexec_firstname, 
 				iexec_lastName, 
 				'At Left Initiated' 
			FROM 
				(
				SELECT 
					r.org_name as rorg_name, 
					r.org_types_id as rorg_types_id, 
					i.org_name as iorg_name, 
					i.org_types_id as iorg_types_id, 
					a.assoc_type as iassoc_type, 
					e.firstname as iexec_firstname, 
	 				e.lastname as iexec_lastname 
				FROM 
				executives as e
				INNER JOIN
				relationships as l
				ON 
				e.id = l.executive_id
				RIGHT OUTER JOIN
				organizations AS r
				ON 
				l.organization_id = r.id
				INNER JOIN
				associations AS a
				ON 
				r.id = a.receiver_id 
				INNER JOIN 
				organizations AS i 
				ON 
				a.initiator_id = i.id 
				WHERE i.org_name = ? 
				OR 
				r.org_name = ?
	 			) 
			AS associations2 
			WHERE iorg_name != ?
			;", 
		org_name, 
		org_name, 
		org_name, 
		org_name, 
		org_name, 
		org_name
		]);	
 	end

	 			# e.firstname as rexec_firstname 

# Other definitions

# tracks_unlinked_activities [:invited_partners]
	
# def can_request_deal_with(organization)
#     !self.eql?(organization) && !self.deal_exists_with?(organization)
#   end

# def deal_exists_with?(partner)
#     Deal.where("organization_id = ? AND partner_id = ?", self.id, partner.id).first
# end

# def has_reached_daily_partner_request_limit?
#     deals_initiated_by_me.where('created_at > ?', Time.now.beginning_of_day).count >= Deal.daily_request_limit
# end

# def network_activity(page = {}, since = 1.week.ago)
#     page.reverse_merge! :per_page => 10, :page => 1
#     partner_ids = self.partners_ids
#     # metro_area_people_ids = self.metro_area ? self.metro_area.users.map(&:id) : []

#     ids = ((partners_ids) - [self.id])[0..100] #don't pull TOO much activity for now
# 	# Could be ids = (partners_ids) | metro_area_orgs_ids)

#     Activity.recent.since(since).by_organizations(ids).page(page[:page]).per(page[:per_page])
# end

# def partners_ids
#     return [] if accepted_deals.empty?
#     accepted_deals.map{|fr| fr.partner_id }
# end

end
