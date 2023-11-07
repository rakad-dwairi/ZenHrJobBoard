class AuthenticationController < ApplicationController
    skip_before_action :authenticate_request
    skip_load_and_authorize_resource
  
    # Action to handle user login
    def login
      @user = User.find_by_email(params[:email])
  
      if @user
        if @user.authenticate(params[:password])
          token = jwt_encode(user_id: @user.id)
          render json: { user_id: @user.id, role: @user.role, email: @user.email, token: token }, status: :ok
        else
          render json: { error: 'Incorrect password' }, status: :unauthorized
        end
      else
        render json: { error: 'User not found' }, status: :not_found
      end
    end
  end
  