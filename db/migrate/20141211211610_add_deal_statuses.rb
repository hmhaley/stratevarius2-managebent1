class AddDealStatuses < ActiveRecord::Migration

  def change
    FriendshipStatus.enumeration_model_updates_permitted = true    
    FriendshipStatus.create :name => "pending"
    FriendshipStatus.create :name => "accepted"
    FriendshipStatus.create :name => "denied"
    FriendshipStatus.enumeration_model_updates_permitted = false
  end

end