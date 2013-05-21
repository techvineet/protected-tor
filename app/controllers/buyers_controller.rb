class BuyersController < ApplicationController
  
  before_filter :authenticate_user!
  
  def show
    @user = Buyer.find_by_uuid params[:id]
  end
  
  def edit
    @user = Buyer.find_by_uuid params[:id]
  end
  
  def update
    @user = Buyer.find_by_uuid params[:id]
    
    respond_to do |format|
      if @user == current_user
        if @user.update_attributes(params[:buyer])
          format.html  { redirect_to(buyer_path(current_user.uuid), :notice => 'Your profile was successfully updated.') }
        else
          format.html  { render :action => "edit" }
        end
      else
        format.html  { redirect_to(account_index_path, :alert => 'Access Denied!') }
      end
    end
  end
  
end
