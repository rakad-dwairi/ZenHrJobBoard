class JobApplicationsController < ApplicationController
    before_action :authenticate_user, only: [:create, :index]
  
    def index
      @job_applications = current_user.job_applications
      render json: @job_applications
    end
  
    def create
      job_application = current_user.job_applications.new(job_application_params)
  
      if job_application.save
        render json: job_application, status: :created
      else
        render json: { errors: job_application.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    def update
      job_application = JobApplication.find(params[:id])
      job_application.update(status: 'Seen')
      render json: job_application
    end
  
    private
  
    def job_application_params
      params.require(:job_application).permit(:job_post_id)
    end
  end
  