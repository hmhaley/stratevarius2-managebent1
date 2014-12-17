class CreateConfirmationStatuses < ActiveRecord::Migration

	def change
    	create_table :confirmation_statuses do |t|
      		t.string :name
  		end
  	end
end
