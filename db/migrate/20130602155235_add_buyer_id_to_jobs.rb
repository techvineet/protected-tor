class AddBuyerIdToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :buyer_id, :integer
  end
end
