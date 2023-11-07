class NotificationsMailer < ApplicationMailer
    def application_seen_email(user)
      @user = user
      mail(to: @user.email, subject: 'Your Application Has Been Seen')
    end
  end
  