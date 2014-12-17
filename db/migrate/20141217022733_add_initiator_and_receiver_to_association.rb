class AddInitiatorAndReceiverToAssociation < ActiveRecord::Migration

  def change
    add_reference :associations, :initiator_id, index: true
    add_reference :associations, :receiver_id, index: true

    add_column :associations, :created_by_exec_id, :integer
	add_column :associations, :confirmation_status_id, :integer

	add_column :associations, :start_date_month, :integer
	add_column :associations, :start_date_year, :integer
	add_column :associations, :end_date_month, :integer
	add_column :associations, :end_date_year, :integer
	add_column :associations, :is_verified_by_staff, :string
	add_column :associations, :is_verified_by_thirdparty, :string

	add_column :associations, :staff_comments_on_deal, :text

  end

end
