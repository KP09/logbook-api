class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  # en.user_mailer.welcome.subject

  def welcome(user)
    @user = user
    @token = user.confirmation_token

    mail(to: @user.email, subject: "Confirm your Passage Logger email address")
  end
end
