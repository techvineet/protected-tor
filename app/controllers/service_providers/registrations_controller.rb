class ServiceProviders::RegistrationsController < Devise::RegistrationsController
  
  def new
    if user_signed_in? or buyer_signed_in? or service_provider_signed_in?
      flash[:alert] = I18n.t("devise.failure.already_authenticated")
      redirect_to account_index_path
      return
    end
    build_resource({})
    self.resource.build_service_provider_detail
    self.resource.services.build
    self.resource.certifications.build
    respond_with self.resource
  end
  
  def create
    
    self.resource = ServiceProvider.new(params[:service_provider])
    resource.build_service_provider_detail if resource.service_provider_detail.nil?
    resource.services.build unless resource.services.present?
    resource.certifications.build unless resource.certifications.present?
    
    if resource.save
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_navigational_format?
        sign_up(resource_name, resource)
        respond_with resource, :location => after_sign_up_path_for(resource)
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_navigational_format?
        expire_session_data_after_sign_in!
        respond_with resource, :location => after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      respond_with resource
    end
  end
  
  def update
    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
    prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)

    if resource.update_with_password(params[:service_provider])
      if is_navigational_format?
        flash_key = update_needs_confirmation?(resource, prev_unconfirmed_email) ?
          :update_needs_confirmation : :updated
        set_flash_message :notice, flash_key
      end
      sign_in "user", resource
      sign_in "service_provider", resource
      respond_with resource, :location => account_index_path
    else
      clean_up_passwords resource
      respond_with resource
    end
  end
  
end
