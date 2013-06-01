class AddAncestryToCategories < ActiveRecord::Migration
  def up
    add_column :categories, :ancestry, :string
    add_index :categories, :ancestry
  end
  def down
    remove_column :categories, :ancestry
    remove_index :categories, :ancestry
  end
end
