class JobApplicationsController < ApplicationController
    before_action :authenticate_user, only: [:create]
    
  
    def index
      job_applications = JobApplication.all
      render json: job_applications
    end
  
    def create
      job_application = current_user.job_applications.build(job_application_params)
      job_application.status = false # Default status is "Not Seen"
      
      if job_application.save
        render json: job_application, status: :created
      else
        render json: { errors: job_application.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    private
  
    def update
        job_application = JobApplication.find(params[:id])
        job_application.update(status: params[:status])
    
        # Trigger email notification
        JobApplicationMailer.status_changed_notification(job_application).deliver_now
    
        render json: job_application
      end
      
    def job_application_params
      params.require(:job_application).permit(:job_post_id)
    end
  end
  