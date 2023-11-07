class UsersController < ApplicationController
    skip_before_action :authenticate_request, only: [:create]
    before_action :set_user, only: [:update, :destroy]
    skip_load_and_authorize_resource :only => [:create, :get_current_user]

    def index
        @users = User.all
        render json: @users
    end

    def show
        render json: @user
    end

    def get_current_user
        render json: @current_user
    end

    def create
        @user = User.new(user_params)
        if @user.save
            render json: @user, status: :created
        else
            render json: @user.errors, status: :unprocessable_entity
        end
    end

    def update
        if @user.update(user_params)
            render json: @user
        else
            render json: @user.errors, status: :unprocessable_entity
        end
    end

    def destroy
        @user.destroy
    end

    private

        def set_user
            @user = User.find(params[:id])
        end

        def user_params
            params.permit(:email, :password, :role)
        end
end
