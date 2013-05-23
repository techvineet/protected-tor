class ServiceProviderDetail < ActiveRecord::Base
  attr_accessible :company_name, :insurance, :insurance_amount, :contact_number
  validates :company_name, :presence => true
  validates :insurance_amount, :presence => true, :if => :has_insurance?
  
  def has_insurance?
    insurance
  end
end
