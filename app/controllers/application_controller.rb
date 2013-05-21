class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def after_sign_in_path_for(resource_or_scope)
    stored_location_for(resource_or_scope) || account_index_path
  end
  
end
