class SessionsController < Devise::SessionsController
    
  def create
    rtn = super
    set_flash_message(:notice, :signed_in) if is_navigational_format?
    sign_in(resource.type.underscore, resource.type.constantize.send(:find, resource.id)) unless resource.type.nil?
    rtn
  end
    
end