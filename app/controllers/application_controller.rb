class ApplicationController < ActionController::API
    def authenticate_admin
      render json: { error: 'Unauthorized' }, status: :unauthorized unless current_user&.admin?
    end
  end
  