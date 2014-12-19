class Executive < ActiveRecord::Base
include ActiveModel::SecurePassword

	has_secure_password

	has_many :relationships
	has_many :organizations, through: :relationships

	accepts_nested_attributes_for :relationships, 
	        :reject_if => :all_blank, 
	        :allow_destroy => true
	        
	accepts_nested_attributes_for :organizations

	has_many :associations

	validates_uniqueness_of :username
	validates_length_of :username, minimum: 5, maximum: 20
	validates_length_of :password, minimum: 5, maximum: 20
	validates_length_of :password_digest, minimum: 5, maximum: 20

	validates_presence_of :prefix
	validates_presence_of :firstname
	validates_presence_of :lastname
	validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
	validates_length_of :email, maximum: 255
	validates :email, uniqueness: { case_sensitive: false }
	before_save { |executive| executive.email = executive.email.downcase }
	validates_presence_of :mobile_tel
	validates_presence_of :office_tel

end