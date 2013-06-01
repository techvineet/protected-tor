class Category < ActiveRecord::Base
  attr_accessible :name, :parent
  acts_as_tree

end
