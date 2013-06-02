class Buyer < User
  
  attr_accessible :buyer_detail_attributes
  
  has_one :buyer_detail, :foreign_key => "user_id", :dependent => :destroy
  has_many :jobs
  accepts_nested_attributes_for :buyer_detail
  
end
