class Job < ActiveRecord::Base
  
  belongs_to :buyer
  belongs_to :category
  has_many :photos, :as => :imageable, :dependent => :destroy
  
  paginates_per 4
  
  attr_accessor :category_name, :subcategory_name
  attr_accessible :budget, :category_id, :description, :end_date, :start_date, :status, :title, :category_name, :subcategory_name
  
  validates_inclusion_of :status, :in => STATUSES.keys,
    :message => "value must be in #{STATUSES.values.join ', '}"
  validates :title, :description, :category_name, :subcategory_name, :presence => true
  validates_length_of :description, :minimum => 300, :maximum => 1500
  validates_length_of :title, :maximum => 150
  
  before_save :set_category_id
  
  def status_name
    STATUSES[status]
  end
  
  private
  
  def set_category_id
    category = Category.find_by_name(self.category_name)
    subcategory = category.children.where(:name => self.subcategory_name).first
    self.category_id = subcategory.id
  end
  
end
