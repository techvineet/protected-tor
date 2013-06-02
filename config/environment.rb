# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
MyApplication::Application.initialize!

DRAFT   = 1
POSTED  = 2
  
STATUSES = {
  DRAFT   => 'Draft',
  POSTED  => 'Posted'
}