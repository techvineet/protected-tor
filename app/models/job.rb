class Job < ActiveRecord::Base
  
  belongs_to :buyer
  belongs_to :category
  has_many :photos, :as => :imageable, :dependent => :destroy
  has_many :quotes
  has_one :service_provider
  
  paginates_per 4
  
  attr_accessor :category_name, :subcategory_name
  attr_accessible :budget, :category_id, :description, :end_date, :start_date, :status, :title, :category_name, :subcategory_name,
    :posted_at, :service_provider_id
  
  validates_inclusion_of :status, :in => JOB_STATUSES.keys,
    :message => "value must be in #{JOB_STATUSES.values.join ', '}"
  validates :title, :description, :category_name, :subcategory_name, :presence => true
  validates_length_of :description, :minimum => 300, :maximum => 1500
  validates_length_of :title, :maximum => 150
  
  before_save :set_category_id
  
  scope :with_active_quotes, ->(service_provider_id) { 
    select("jobs.*, quotes.status as quote_status, quotes.request_meeting, quotes.price, quotes.id as quote_id").joins(:quotes).where(:quotes => {:service_provider_id => service_provider_id, :status => PENDING}, :status => POSTED)
  }
  scope :with_accepted_quotes, ->(service_provider_id) { 
    select("jobs.*, quotes.status as quote_status, quotes.request_meeting, quotes.price, quotes.id as quote_id").joins(:quotes).where(:quotes => {:service_provider_id => service_provider_id, :status => ACCEPTED}, :status => CLOSED)
  }
  scope :with_archived_quotes, ->(service_provider_id) { 
    select("jobs.*, quotes.status as quote_status, quotes.request_meeting, quotes.price, quotes.id as quote_id").joins(:quotes).where("quotes.service_provider_id = #{service_provider_id} 
    AND ((quotes.status = #{PENDING} and jobs.status = #{CLOSED}) 
    or (quotes.status = #{JOB_ACCEPTED} and jobs.status = #{CLOSED})
    or (quotes.status = #{REJECTED} and jobs.status = #{POSTED})
    or (quotes.status = #{JOB_REJECTED} and jobs.status IN (#{POSTED},#{CLOSED})))")
  }
  def status_name
    JOB_STATUSES[status]
  end
  
  private
  
  def set_category_id
    if self.category_name.present?
      category = Category.find_by_name(self.category_name)
      subcategory = category.children.where(:name => self.subcategory_name).first
      self.category_id = subcategory.id
    end
  end
  
end
