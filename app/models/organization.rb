class Organization < ActiveRecord::Base
extend ::Geocoder::Model::ActiveRecord

	# validates_uniqueness_of :username
	# validates_presence_of :sector_type
	# validates_presence_of :web_url
	# validates_presence_of :hq_address_city
	# validates_presence_of :hq_address_state
	# validates_presence_of :hq_address_zip
	# validates_presence_of :hq_telephone

	# validates_format_of :hq_email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
	# validates_length_of :hq_email, maximum: 255

#Executive associations, joined by table "relationships"
	has_many :relationships
	has_many :executives, through: :relationships
	accepts_nested_attributes_for :relationships, allow_destroy: true

#Deal associations, joined by table "deals",  new words or variables I don't know if are yet defined: accepted_deals, deal_status, deal_status_id, pending_deals, initiator, deals_initiated_by_me, deals_not_initiated_by_me, occurances_as_partner (same as occurances_as_friend) 

    has_many :deals, :class_name => "Deal", :foreign_key => "organization_id"
    has_many :accepted_deals, -> { where('deal_status_id = ?', 2) }, :class_name => "Deal"
    has_many :pending_deals, -> { where('initiator = ? AND deal_status_id = ?', false, 1) }, :class_name => "Deal"
    has_many :deals_initiated_by_me, -> { where('initiator = ?', true) }, :class_name => "Deal", :foreign_key => "organization_id"
    has_many :deals_not_initiated_by_me, -> { where('initiator = ?', false) }, :class_name => "Deal", :foreign_key => "organization_id"
    has_many :occurances_as_partner, :class_name => "Deal", :foreign_key => "partner_id"

# Other definitions

# tracks_unlinked_activities [:invited_partners]
	
def can_request_deal_with(organization)
    !self.eql?(organization) && !self.deal_exists_with?(organization)
  end

def deal_exists_with?(partner)
    Deal.where("organization_id = ? AND partner_id = ?", self.id, partner.id).first
end

def has_reached_daily_partner_request_limit?
    deals_initiated_by_me.where('created_at > ?', Time.now.beginning_of_day).count >= Deal.daily_request_limit
end

def network_activity(page = {}, since = 1.week.ago)
    page.reverse_merge! :per_page => 10, :page => 1
    partner_ids = self.partners_ids
    # metro_area_people_ids = self.metro_area ? self.metro_area.users.map(&:id) : []

    ids = ((partners_ids) - [self.id])[0..100] #don't pull TOO much activity for now
	# Could be ids = (partners_ids) | metro_area_orgs_ids)

    Activity.recent.since(since).by_organizations(ids).page(page[:page]).per(page[:per_page])
end

def partners_ids
    return [] if accepted_deals.empty?
    accepted_deals.map{|fr| fr.partner_id }
end

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

end
