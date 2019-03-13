class ApplicationMailer < ActionMailer::Base
  default from: 'noreplay@ideashub-api.herokuapp.com'
  layout 'mailer'
end
