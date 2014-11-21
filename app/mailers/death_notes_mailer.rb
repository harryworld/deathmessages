class DeathNotesMailer < ActionMailer::Base
  default from: "Death Notes Administrator <admin@death-notes.co>"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.death_notes_mailer.account_create_notification.subject
  #
  def account_create_notification(email,generated_password)
    @greeting = "Hi"

    @email = email
    @generated_password = generated_password

    mail(:to => @email,
         :subject => "Account Created Notification")
  end
end
