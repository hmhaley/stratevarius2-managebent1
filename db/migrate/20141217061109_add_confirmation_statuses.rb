class AddConfirmationStatuses < ActiveRecord::Migration

  def change
    ConfirmationStatus.enumeration_model_updates_permitted = true    
    ConfirmationStatus.create :name => "pending"
    ConfirmationStatus.create :name => "accepted"
    ConfirmationStatus.create :name => "denied"
    ConfirmationStatus.enumeration_model_updates_permitted = false
  end

end