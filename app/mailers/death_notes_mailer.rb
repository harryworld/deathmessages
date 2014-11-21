class DeathNotesMailer < ActionMailer::Base
  default from: "from@example.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.death_notes_mailer.account_create_notification.subject
  #
  def account_create_notification
    @greeting = "Hi"

    mail to: "to@example.org"
  end
end
