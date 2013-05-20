class ServiceProviderDetail < ActiveRecord::Base
  attr_accessible :company_name, :insurance, :insurance_amount
  validates :company_name, :presence => true
  validates :insurance_amount, :presence => true, :if => :has_insurance?
  
  def has_insurance?
    insurance
  end
end
