class Buyer < User
  
  attr_accessible :buyer_detail_attributes
  
  has_one :buyer_detail, :foreign_key => "user_id"
  accepts_nested_attributes_for :buyer_detail
  
end
