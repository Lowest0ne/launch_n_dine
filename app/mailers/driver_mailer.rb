class DriverMailer < ActionMailer::Base
  default from: "hello@launchndine.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.driver_mailer.registration.subject
  #
  def registration( new_user )
    @greeting = "Launch 'n Dine"

    mail to: new_user.email,
      subject: "Launch 'n Dine Welcomes You"
  end
end
