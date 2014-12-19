class Relationship < ActiveRecord::Base
	
	belongs_to :executive
	belongs_to :organization
	accepts_nested_attributes_for :organization, :reject_if => :all_blank

	validates_presence_of :job_title

end