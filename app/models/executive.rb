class Executive < ActiveRecord::Base
include ActiveModel::SecurePassword

	has_secure_password

	# validates_uniqueness_of :username
	# validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
	# validates_length_of :email, maximum: 255
	# validates_length_of :username, minimum: 4, maximum: 20
	# validates_length_of :password, minimum: 4, maximum: 20
	# validates_length_of :password_digest, minimum: 4, maximum: 20
	# validates_presence_of :firstname
	# validates_presence_of :lastname

	has_many :relationships
	has_many :organizations, through: :relationships

	accepts_nested_attributes_for :relationships, 
           :reject_if => :all_blank, 
           :allow_destroy => true
           
	accepts_nested_attributes_for :organizations

	has_many :associations

end