class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.welcome.subject
  #
  def welcome
    @usuario = params[:user]
    @username = @usuario.username

    mail to: @usuario.email
  end
end
