# spec/controllers/sessions_controller_spec.rb

require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  describe 'POST #create' do
    context 'with valid credentials' do
      let(:user) { create(:user, email: 'user@example.com', password: 'password123') }

      it 'returns a success response with authentication token' do
        post :create, params: { email: user.email, password: 'password123' }
        expect(response).to have_http_status(:ok)

        json_response = JSON.parse(response.body)
        expect(json_response['user']['email']).to eq(user.email)
        expect(json_response['token']).to be_present
      end
    end

    context 'with invalid credentials' do
      it 'returns an unauthorized response' do
        post :create, params: { email: 'invalid@example.com', password: 'wrongpassword' }
        expect(response).to have_http_status(:unauthorized)

        json_response = JSON.parse(response.body)
        expect(json_response['error']).to eq('Invalid email or password')
      end
    end
  end

  # Swagger documentation for /login endpoint
  swagger_path '/login' do
    operation :post do
      key :description, 'Authenticate user and return an access token'
      key :tags, ['Authentication']
      parameter do
        key :name, :email
        key :in, :formData
        key :description, 'Email address'
        key :required, true
        key :type, :string
      end
      parameter do
        key :name, :password
        key :in, :formData
        key :description, 'Password'
        key :required, true
        key :type, :string
      end
      response 200 do
        key :description, 'Authentication successful'
        schema do
          key :type, :object
          property :user, { type: :string }
          property :token, { type: :string }
        end
      end
      response 401 do
        key :description, 'Invalid email or password'
      end
    end
  end
end
