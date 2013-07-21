class ChangeMessageTypeInQuote < ActiveRecord::Migration
  def up
    change_column :quotes, :message, :text
  end

  def down
    change_column :quotes, :message, :string
  end
end
