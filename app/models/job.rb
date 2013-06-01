class Job < ActiveRecord::Base
  
  DRAFT    = 1
  POSTED    = 2
  
  STATUSES = {
    DRAFT    => 'draft',
    POSTED    => 'posted'
  }
  
  attr_accessible :budget, :category_id, :description, :end_date, :start_date, :status, :title
  
  validates_inclusion_of :status, :in => STATUSES.keys,
    :message => "{{value}} must be in #{STATUSES.values.join ','}"

  def status_name
    STATUSES[status]
  end
  
end
