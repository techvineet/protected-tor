class Photo < ActiveRecord::Base
  attr_accessible :service_provider_id, :upload
  belongs_to :imageable, :polymorphic => true
  
  has_attached_file :upload,
    :styles => {
      :thumb => "80x80#",
      :small => "260x180#"
    }
  
  include Rails.application.routes.url_helpers

  def to_jq_upload
    {
      "name" => read_attribute(:upload_file_name),
      "size" => read_attribute(:upload_file_size),
      "url" => upload.url(:original),
      "delete_url" => photo_path(self),
      "delete_type" => "DELETE",
      "thumbnail_url" => upload.url(:thumb),
      "small_url" => upload.url(:small)
    }
  end

end
