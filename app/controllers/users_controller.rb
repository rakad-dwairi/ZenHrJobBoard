class UsersController < ApplicationController
    skip_before_action :authenticate_request, only: [:create]
    before_action :set_user, only: [:update, :destroy]
    skip_load_and_authorize_resource :only => [:create, :get_current_user]
  
    # GET /users
    def index
      @users = User.all
      render json: @users
    end
  
    # GET /users/:id
    def show
      render json: @user
    end
  
    # GET /get_current_user
    def get_current_user
      render json: @current_user
    end
  
    # POST /users
    def create
      @user = User.new(user_params)
      @user.role = "jobseeker" # Set role to jobseeker for all new users
      if @user.save
        render json: @user, status: :created
      else
        render json: @user.errors, status: :unprocessable_entity
      end
    end
  
    # PATCH /users/:id
    def update
      if params[:role].present?
        render json: { error: "Modifying the role is forbidden" }, status: :unprocessable_entity
      else
        if @user.update(user_params)
          render json: @user
        else
          render json: @user.errors, status: :unprocessable_entity
        end
      end
    end
  
    # DELETE /users/:id
    def destroy
      @user.destroy
    end
  
    private
  
    def set_user
      @user = User.find(params[:id])
    end
  
    def user_params
      params.permit(:email, :password)
    end
  end
  