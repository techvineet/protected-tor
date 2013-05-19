class CreateBuyerDetails < ActiveRecord::Migration
  def change
    create_table :buyer_details do |t|
      t.integer :user_id
      t.string :location

      t.timestamps
    end
  end
end
