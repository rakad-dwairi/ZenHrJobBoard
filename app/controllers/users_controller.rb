class UsersController < ApplicationController
    skip_before_action :authenticate_request, only: [:create]
    before_action :set_user, only: [:update, :destroy]
    skip_load_and_authorize_resource :only => [:create, :get_current_user]

    def index
        begin
            @users = User.all
            render json: @users
        rescue StandardError => e
            render json: { error: e.message }, status: :unprocessable_entity
        end
    end

    def show
        begin
            render json: @user
        rescue ActiveRecord::RecordNotFound => e
            render json: { error: e.message }, status: :not_found
        end
    end

    def get_current_user
        begin
            render json: @current_user
        rescue StandardError => e
            render json: { error: e.message }, status: :unprocessable_entity
        end
    end

    def create
        begin
            @user = User.new(user_params)
            @user.role = "jobseeker"
            if @user.save
                render json: @user, status: :created
            else
                render json: @user.errors, status: :unprocessable_entity
            end
        rescue StandardError => e
            render json: { error: e.message }, status: :unprocessable_entity
        end
    end

    def update
        begin
            if params[:role].present?
                render json: { error: "Modifying the role is forbidden" }, status: :unprocessable_entity
            else
                if @user.update(user_params)
                    render json: @user
                else
                    render json: @user.errors, status: :unprocessable_entity
                end
            end
        rescue StandardError => e
            render json: { error: e.message }, status: :unprocessable_entity
        end
    end

    def destroy
        begin
            @user.destroy
        rescue StandardError => e
            render json: { error: e.message }, status: :unprocessable_entity
        end
    end


    private

    def set_user
        @user = User.find(params[:id])
    rescue ActiveRecord::RecordNotFound => e
        render json: { error: e.message }, status: :not_found
    end

    def user_params
        params.permit(:email, :password)
    end
end
