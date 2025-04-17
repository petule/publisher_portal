class ApplicationMailer < ActionMailer::Base
  default from: CONFIG['from_email']
  layout "mailer"
end
