class JobApplicationMailer < ApplicationMailer
    def status_changed_notification(job_application)
      @job_application = job_application
      @user = job_application.user
      @job_post = job_application.job_post
  
      mail(to: @user.email, subject: "Job Application Status Update")
    end
  end
  