class QuotesController < ApplicationController
  before_filter :authenticate_user!
  
  def index
    if params[:service_provider_id].present?
      user_id = params[:service_provider_id]
    else
      user_id = params[:buyer_id]
    end
    if user_id.present? and current_user.uuid == user_id
      if current_user.class == ServiceProvider
        @active_quotes = Job.with_active_quotes(current_user.id)
        @accepted_quotes = Job.with_accepted_quotes(current_user.id)
        @archived_quotes = Job.with_archived_quotes(current_user.id)
      elsif current_user.class == Buyer
        @job = Job.find_by_id(params[:job_id])
        raise ActiveRecord::RecordNotFound if @job.nil? or (@job.present? and @job.status == DRAFT)
      end
    else
      redirect_to root_path
    end
  end
  
  def show
    
  end
  
  def create
    @job = Job.find_by_id(params[:job_id])
    
    raise ActiveRecord::RecordNotFound if @job.nil? or (@job.present? and not @job.status == POSTED)
    
    price = params[:quote][:price]
    unless price.nil?
      price = price.gsub(",","").to_i
      price = nil if price == 0
      params[:quote][:price] = price
    end
    
    @quote = current_user.quotes.new(params[:quote])
    @quote.job = @job
    @quote.status = PENDING
    
    respond_to do |format|
      if @quote.save
        flash[:notice] = "Your quote has been submitted. We will notify you once the quote is accepted."
        format.js
      else
        format.js
      end
    end
  
  end
  
  def update
    if current_user.class == Buyer
      job = current_user.jobs.find_by_id(params[:job_id]) rescue nil
    elsif current_user.class == ServiceProvider
      job = Job.find_by_id(params[:job_id]) rescue nil
    end
    quote = job.quotes.find_by_id(params[:id]) rescue nil
    if quote.present? and job.present?
      if current_user.class == Buyer
        if quote.status == PENDING and job.status == POSTED
          ActiveRecord::Base.transaction do
            quote.update_attributes(:status => ACCEPTED)
            job.status = CLOSED
            job.service_provider_id = quote.service_provider_id
            job.save(:validate => false)
            flash[:notice] = "Job was successfully awarded. You will be notified once the Service Provider accepts the job."  
          end
        end
      elsif current_user.class == ServiceProvider
        if quote.status == ACCEPTED
          params[:quote][:status] = params[:quote][:status].to_i
          if params[:quote][:status] == JOB_ACCEPTED
            quote.status = params[:quote][:status]
            if quote.save
              flash[:notice] = "The job was successfully accepted."
            else
              flash[:alert] = "Opps! An error occured in accepting the job. Please try again."
            end
          else params[:quote][:status] == JOB_REJECTED
            ActiveRecord::Base.transaction do
              quote.status = params[:quote][:status]
              quote.save
              job.status = POSTED
              job.save(:validate => false)
              flash[:notice] = "The job was rejected."
            end
          end
        end
      end
    end
    redirect_to :back
  end
  
end
