class Certification < ActiveRecord::Base
  
  attr_accessible :name, :service_provider_id
  belongs_to :service_provider
  
end
