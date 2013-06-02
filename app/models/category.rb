class Category < ActiveRecord::Base
  attr_accessible :name, :ancestry
  acts_as_tree

end
