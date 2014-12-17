class CreateDealStatuses < ActiveRecord::Migration

	def change
	    create_table :deal_statuses do |t|
      		t.string :name
  		end
  	end
end