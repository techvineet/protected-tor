class ServiceProviders::RegistrationsController < Devise::RegistrationsController
  
  def new
    build_resource({})
    self.resource.build_service_provider_detail if self.resource.service_provider_detail.nil?
    respond_with self.resource
  end
  
end
