class ServiceProvider < User
  
  attr_accessible :service_provider_detail_attributes
  
  has_one :service_provider_detail, :foreign_key => "user_id"
  accepts_nested_attributes_for :service_provider_detail
  
end
