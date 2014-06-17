# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Fight::Application.initialize!

ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.perform_deliveries = true
ActionMailer::Base.raise_delivery_errors = true
ActionMailer::Base.default :content_type => "text/html"


ActionMailer::Base.smtp_settings = {
  :address              => "smtp.gmail.com",
  :port                 => 587,
  :domain               => "gmail.com",
  :user_name            => "mycombate@gmail.com",
  :password             => "mycombate123",
  :authentication       => "plain",
  :enable_starttls_auto => true
}