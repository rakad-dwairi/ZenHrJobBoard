class ApplicationController < ActionController::API
    include JsonWebToken
    before_action :authenticate_request
    load_and_authorize_resource

    rescue_from CanCan::AccessDenied do |exception|
        render json: { error: 'Unauthorized' }, status: :unauthorized
    end

    private

        def authenticate_request
            header = request.headers["Authorization"]
            if header.nil? || header.blank?
                render json: { error: 'Unauthorized' }, status: :unauthorized
            else
                header = header.split(" ").last
                begin
                    decoded = jwt_decode(header)
                    @current_user = User.find(decoded[:user_id])
                    @ability = Ability.new(@current_user)
                rescue ActiveRecord::RecordNotFound
                    render json: { error: 'Record not found' }, status: :not_found
                rescue JWT::DecodeError
                    render json: { error: 'Invalid token' }, status: :unprocessable_entity
                end
            end
        end

        
        def current_user
            @current_user 
        end

end