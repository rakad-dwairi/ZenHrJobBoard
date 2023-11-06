class ApplicationController < ActionController::API
    def authenticate_request
      @current_user = JwtService.decode(request.headers['Authorization'])
      render json: { error: 'Unauthorized' }, status: :unauthorized unless @current_user
    end
  
    def current_user
      @current_user
    end
  
    def authenticate_admin
      render json: { error: 'Unauthorized' }, status: :unauthorized unless current_user&.admin?
    end
  end
  