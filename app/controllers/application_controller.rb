class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def after_sign_in_path_for(resource_or_scope)
    stored_location_for(resource_or_scope) || account_index_path
  end
  
#  def present_user
#    if user_signed_in? 
#      @present_user = current_user
#    elsif buyer_signed_in?
#      @present_user = current_buyer
#    elsif service_provider_signed_in?
#      @present_user = current_
#    else  
#    
#    end
#  end
#  helper_method :current_user

end
