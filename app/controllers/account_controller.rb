class AccountController < ApplicationController
  
  before_filter :authenticate_user!
  
  def index
    if current_user.class.to_s == "ServiceProvider"
      @jobs = Job.where(:status => POSTED).order(sort_by_params).page params[:page]
      if request.xhr?
        respond_to do |format|
          format.js
        end
      end
    end
  end
  
  private
  
  def sort_by_params
    order = params[:order].present? ? params[:order] : "updated_at"
    case order
    when "start_date"
      return "#{order} ASC"
    when "end_date"
      return "#{order} ASC"    
    else
      return "#{order} DESC"
    end
  end
  
end
