class JobApplicationMailer < ApplicationMailer
    def status_changed_notification(job_application)
      @job_application = job_application
      mail(to: @job_application.user.email, subject: 'Job Application Status Changed')
    end
  end
  