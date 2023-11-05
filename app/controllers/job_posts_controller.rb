class JobPostsController < ApplicationController
    before_action :authenticate_admin, only: [:create, :update, :destroy]

  
    def index
      job_posts = JobPost.all
      render json: job_posts
    end
  
    def create
      job_post = JobPost.new(job_post_params)
      if job_post.save
        render json: job_post, status: :created
      else
        render json: { errors: job_post.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    def update
      job_post = JobPost.find(params[:id])
      if job_post.update(job_post_params)
        render json: job_post
      else
        render json: { errors: job_post.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    def destroy
      job_post = JobPost.find(params[:id])
      job_post.destroy
      head :no_content
    end
  
    private
  
    def job_post_params
      params.require(:job_post).permit(:title, :description, :expiry_date)
    end
  end
  