class ServiceProviderDetail < ActiveRecord::Base
  attr_accessible :company_name, :insurance, :insurance_amount
  validates :company_name, :presence => true
end
