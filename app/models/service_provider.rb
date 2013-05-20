class ServiceProvider < User
  
  attr_accessible :service_provider_detail_attributes, :services_attributes, :certifications_attributes
  
  has_one :service_provider_detail, :foreign_key => "user_id"
  has_many :certifications
  has_many :services
  
  #validates_associated :service_provider_detail
  
  accepts_nested_attributes_for :service_provider_detail
  accepts_nested_attributes_for :services, :reject_if => lambda { |a| a[:name].blank? }, :allow_destroy => true
  accepts_nested_attributes_for :certifications, :reject_if => lambda { |a| a[:name].blank? }, :allow_destroy => true

end
