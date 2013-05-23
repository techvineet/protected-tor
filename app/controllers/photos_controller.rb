class PhotosController < ApplicationController
  
  def index
    @photos = current_user.photos

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
    @photo = Photo.new(params[:photo])
    @photo.service_provider_id = current_user.id
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
    @photo = Photo.find(params[:id])
    @photo.destroy

    respond_to do |format|
      format.html { redirect_to photos_url }
      format.json { head :no_content }
    end
  end
end