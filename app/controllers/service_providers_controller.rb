class ServiceProvidersController < ApplicationController
  
  before_filter :authenticate_user!
  
  def show
    @user = ServiceProvider.find_by_uuid params[:id]
  end
  
  def edit
    @user = ServiceProvider.find_by_uuid params[:id]
  end
  
  def update
    @user = ServiceProvider.find_by_uuid params[:id]
    
    respond_to do |format|
      if @user == current_user
        if @user.update_attributes(params[:service_provider])
          format.html  { redirect_to(service_provider_path(current_user.uuid), :notice => 'Your profile was successfully updated.') }
        else
          format.html  { render :action => "edit" }
        end
      else
        format.html  { redirect_to(account_index_path, :alert => 'Access Denied!') }
      end
    end
  end
  
end
