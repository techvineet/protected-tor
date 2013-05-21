class Buyers::RegistrationsController < Devise::RegistrationsController
  
  def new
    
    if user_signed_in? or buyer_signed_in? or service_provider_signed_in?
      flash[:alert] = I18n.t("devise.failure.already_authenticated")
      redirect_to account_index_path
      return
    end
    
    build_resource({})
    self.resource.build_buyer_detail if self.resource.buyer_detail.nil?
    respond_with self.resource
  
  end
  
  def update
    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
    prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)

    if resource.update_with_password(params[:buyer])
      if is_navigational_format?
        flash_key = update_needs_confirmation?(resource, prev_unconfirmed_email) ?
          :update_needs_confirmation : :updated
        set_flash_message :notice, flash_key
      end
      sign_in "user", resource
      sign_in "buyer", resource
      respond_with resource, :location => account_index_path
    else
      clean_up_passwords resource
      respond_with resource
    end
  end
  
end
