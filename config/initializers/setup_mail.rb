ActionMailer::Base.smtp_settings = {
  :address              => "smtp.gmail.com",
  :port                 => 587,
  :domain               => "gmail.com",
  :user_name            => "myherokuapps",
  :password             => "her0ku@pps",
  :authentication       => "plain",
  :enable_starttls_auto => true
}
ActionMailer::Base.default :from => "MyApplication <myherokuapps@gmail.com>"
ActionMailer::Base.default_url_options[:host] = "localhost:3000"
#Mail.register_interceptor(DevelopmentMailInterceptor) if Rails.env.development?