class ServiceProviders::RegistrationsController < Devise::RegistrationsController
  
  def new
    
    if user_signed_in? or buyer_signed_in? or service_provider_signed_in?
      flash[:alert] = I18n.t("devise.failure.already_authenticated")
      redirect_to root_path
      return
    end
    
    build_resource({})
    self.resource.build_service_provider_detail if self.resource.service_provider_detail.nil?
    respond_with self.resource
  
  end
  
end
