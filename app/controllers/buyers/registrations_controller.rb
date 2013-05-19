class Buyers::RegistrationsController < Devise::RegistrationsController
  
  def new
    build_resource({})
    self.resource.build_buyer_detail if self.resource.buyer_detail.nil?
    respond_with self.resource
  end
  
end
