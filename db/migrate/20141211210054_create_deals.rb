class CreateDeals < ActiveRecord::Migration

	def change
	    create_table :deals do |t|
	      t.integer :deal_status_id
	      t.integer :partner_id
	      t.integer :organization_id
	      t.boolean :initiator, default: false
	      t.string :deal_type
	      t.string :deal_description
	      t.string :is_deal_current
	      t.integer :start_date_month
	      t.integer :start_date_year
	      t.integer :end_date_month
	      t.integer :end_date_year
	      t.string :is_verified_by_org
	      t.string :is_verified_by_staff
	      t.string :is_verified_by_thirdparty
	      t.integer :created_by_exec_id
	      t.string :staff_comments_on_deal

	      t.timestamps null: false

    	end
    end

end