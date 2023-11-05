class SessionsController < ApplicationController
    def create
      user = User.find_by(email: params[:email])
      
      if user && user.authenticate(params[:password])
        token = encode_token(user_id: user.id)
        render json: { user: user, token: token }, status: :ok
      else
        render json: { error: 'Invalid email or password' }, status: :unauthorized
      end
    end
  
    private
  
    def encode_token(payload)
      JWT.encode(payload, 'your_secret_key', 'HS256')
    end
  end
  