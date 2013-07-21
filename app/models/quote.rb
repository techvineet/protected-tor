class Quote < ActiveRecord::Base
  
  attr_accessible :job_id, :service_provider_id, :price, :request_meeting, :message, :status
  
  belongs_to :job
  belongs_to :service_provider
  
  validates :job_id, :uniqueness => { :scope => :service_provider_id, :message => "You have submitted your quote for this job." }
  validates_inclusion_of :status, :in => QUOTE_STATUSES.keys,
    :message => "value must be in #{QUOTE_STATUSES.values.join ', '}"
  validates_length_of :message, :minimum => 50, :maximum => 300, :allow_blank => true
  validates :price, :presence => true, :if => Proc.new { |quote| not quote.request_meeting }
  
  def status_name
    QUOTE_STATUSES[status]
  end
  
end
