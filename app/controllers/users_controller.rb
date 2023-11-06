class UsersController < ApplicationController
    def create
        user = User.new(user_params)
        user.admin = params[:user][:admin] == "false"
      
        if user.save
          render json: user, status: :created
        else
          render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
        end
      end
  
    private
  
    def user_params
        params.require(:user).permit(:email, :password, :admin)
    end
  end
  