class CreateDeals < ActiveRecord::Migration

	def change
	    create_table :deals do |t|
	      t.column :partner_id, :integer
	      t.column :organization_id, :integer
	      t.column "initiator", :boolean, :default => false
	      t.column "created_at", :datetime
	      t.column "deal_status_id", :integer
    	end
    end

end