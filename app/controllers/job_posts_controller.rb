class JobPostsController < ApplicationController
    
    before_action :set_job_post, only: [:show, :update, :destroy]

    def index
        @job_posts = JobPost.all
        render json: @job_posts
    end

    def show
        render json: @job_post
    end

    def create
        @job_post = JobPost.new(job_post_params)
        @job_post.user = @current_user
        if @job_post.save
            render json: @job_post, status: :created
        else
            render json: @job_post.errors, status: :unprocessable_entity
        end
    end

    private

        def set_job_post
            @job_post = JobPost.find(params[:id])
        end

        def job_post_params
            params.permit(:title, :description)
        end


end
