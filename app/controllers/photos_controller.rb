class PhotosController < ApplicationController
  
  before_filter :load_resource
  
  def index
    @photos = @resource.photos
    respond_to do |format|
      format.html
      format.json { render :json => @photos.map{|photo| photo.to_jq_upload } }
    end
  end
  

  def show
    @photo = Photo.find(params[:id])
    respond_to do |format|
      format.html
      format.json { render :json => @photo }
    end
  end

  
  def new
    @photo = Photo.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @photo }
    end
  end

  
  def edit
    @photo = Photo.find(params[:id])
  end

  
  def create
    @photo = @resource.photos.new(params[:photo])
    respond_to do |format|
      if @photo.save
        format.html {
          render :json => [@photo.to_jq_upload].to_json,
          :content_type => 'text/html',
          :layout => false
        }
        format.json { render :json => {:files => [@photo.to_jq_upload]}, :status => :created, :location => @photo }
      else
        format.html { render :action => "new" }
        format.json { render :json => @photo.errors, :status => :unprocessable_entity }
      end
    end
  end

  
  def update
    @photo = Photo.find(params[:id])

    respond_to do |format|
      if @photo.update_attributes(params[:photo])
        format.html { redirect_to @photo, :notice => 'Photo was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @photo.errors, :status => :unprocessable_entity }
      end
    end
  end

  
  def destroy
    ## TODO: Add some security
    @photo = Photo.find(params[:id])
    @photo.destroy

    respond_to do |format|
      format.html { redirect_to photos_url }
      format.json { head :no_content }
    end
  end
  
  
  private

  
  def load_resource
    if params[:service_provider_id].present?
      @resource = User.find_by_uuid(params[:service_provider_id])
      @resource = User.find_by_id(params[:service_provider_id]) if @resource.nil?
    elsif params[:job_id].present?
      @resource = Job.find_by_id(params[:job_id])
    end
  end
  
end