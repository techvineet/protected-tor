class User < ActiveRecord::Base
  
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

         
  attr_accessible :email, :password, :password_confirmation, :remember_me, :about_me, :email, :first_name, :last_name
  before_create :create_uuid
  
  validates :first_name, :last_name, :presence => true
  
  def name
    first_name + " " + last_name
  end
  
  private
  
  def create_uuid
    self.uuid = UUIDTools::UUID.timestamp_create().to_s
  end
  
end
