class Association < ActiveRecord::Base

	belongs_to :initiator, class_name: "Organization",
	  foreign_key: :initiator_id, inverse_of: :initiators
	belongs_to :receiver, class_name: "Organization",
	  foreign_key: :receiver_id, inverse_of: :receivers

	belongs_to :executive, class_name: "Executive",
	  foreign_key: :created_by_exec_id

	has_enumerated :confirmation_status, :class_name => 'ConfirmationStatus', :foreign_key => 'confirmation_status_id'

end
