class AddDealStatuses < ActiveRecord::Migration

  def change
    DealStatus.enumeration_model_updates_permitted = true    
    DealStatus.create :name => "pending"
    DealStatus.create :name => "accepted"
    DealStatus.create :name => "denied"
    DealStatus.enumeration_model_updates_permitted = false
  end

end