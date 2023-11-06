class SessionsController < ApplicationController
    def create
      user = User.find_by(email: params[:email])
  
      if user && user.authenticate(params[:password])
        token = JwtService.encode(user_id: user.id)
        render json: { user: user, token: token, admin: user.admin? }, status: :ok
    else
        render json: { error: 'Invalid email or password' }, status: :unauthorized
      end
    end
  end
  