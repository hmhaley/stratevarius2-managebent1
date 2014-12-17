class CreateAssociations < ActiveRecord::Migration
  def change
  	
    create_table :associations do |t|
      t.string :assoc_type
      t.text :assoc_description
      t.string :is_deal_current

      t.timestamps
    end
  end
end
