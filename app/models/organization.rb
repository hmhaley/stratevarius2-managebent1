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


	has_many :relationships
	has_many :executives, through: :relationships
	accepts_nested_attributes_for :relationships, allow_destroy: true
	
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
