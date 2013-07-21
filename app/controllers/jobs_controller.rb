class JobsController < ApplicationController
  
  before_filter :authenticate_user!
  before_filter :set_status, :only => [:create, :update]
  
  def index
    if params[:buyer_id].present?
      @jobs = current_user.jobs.order(sort_by_params).page params[:page]
      if request.xhr?
        respond_to do |format|
          format.js
        end
      end
    end
  end
  
  def new
    @categories = Category.where(:ancestry => nil)
    @job = Job.new
  end
  
  def create
    
    budget = params[:job][:budget]
    unless budget.nil?
      budget = budget.gsub(",","").to_i
      budget = nil if budget == 0
    end
    params[:job][:budget] = budget
    
    @job = current_user.jobs.new(params[:job])
    @categories = Category.where(:ancestry => nil)
    if @job.status == POSTED and @job.posted_at.nil?
      @job.posted_at = Time.now.to_formatted_s(:db)
    end
    respond_to do |format|
      if @job.save
        if @job.status == POSTED
          format.html  { redirect_to(buyer_jobs_path(current_user.uuid), :notice => 'Job posted successfully.') }
        else  
          format.html  { redirect_to(edit_buyer_job_path(current_user.uuid, @job.id), :notice => 'Job saved successfully. ') }
        end
      else
        format.html { render :action => "new" }
      end
    end
  end
  
  def show
    @job = Job.find_by_id(params[:id])
    raise ActiveRecord::RecordNotFound if @job.nil? or (@job.present? and not (@job.status == POSTED or @job.status == CLOSED))
    @quote = current_user.quotes.find_by_job_id(params[:id])
    flash.now[:alert] = "This Job Posting is closed." if @job.status == CLOSED
  end
  
  def edit
    @job = current_user.jobs.where(:id => params[:id]).first
    @job.subcategory_name = Category.find_by_id(@job.category_id).name
    @job.category_name = Category.find_by_id(@job.category_id).parent.name
    @categories = Category.where(:ancestry => nil)
    @resource = @job
  end
  
  def update
    
    budget = params[:job][:budget]
    unless budget.nil?
      budget = budget.gsub(",","").to_i
      budget = nil if budget == 0
    end
    params[:job][:budget] = budget
    
    @job = current_user.jobs.where(:id => params[:id]).first
    @categories = Category.where(:ancestry => nil)
    respond_to do |format|
      if @job.update_attributes(params[:job])
        if @job.status == POSTED
          if @job.posted_at.nil?
            @job.posted_at = Time.now.to_formatted_s(:db)
            @job.save
          end        
          format.html  { redirect_to(buyer_jobs_path(current_user.uuid), :notice => 'Job posted successfully.') }
        else  
          format.html  { redirect_to(buyer_job_path(current_user.uuid, @job.id), :notice => 'Job saved successfully. ') }
        end
      else
        format.html { render :action => "show" }
      end
    end
  end
  
  private
  
  def set_status
    params[:job][:status] = params[:button].to_i
  end
  
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
