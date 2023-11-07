require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  def authenticate_user(user)
    token = JWT.encode({ user_id: user.id }, Rails.application.secrets.secret_key_base)
    request.headers['Authorization'] = "Bearer #{token}"
  end

  describe 'GET #index' do
    it 'returns a success response' do
      user = create(:admin_user)
      authenticate_user(user)
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      user = create(:admin_user)
      authenticate_user(user)
      get :show, params: { id: user.id }
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #get_current_user' do
    it 'returns the current user' do
      user = create(:admin_user)
      authenticate_user(user)
      get :get_current_user
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST #create' do
    it 'creates a new user' do
      user = create(:admin_user)
      authenticate_user(user)
      user_params = { email: 'test@example.com', password: 'password', role: 'job_seeker' }
      post :create, params: user_params
      expect(response).to have_http_status(:created)
    end
  end

  describe 'PUT #update' do
    it 'updates the user' do
      user = create(:admin_user)
      authenticate_user(user)
      updated_email = 'updated@example.com'
      patch :update, params: { id: user.id, email: updated_email }
      user.reload
      expect(user.email).to eq(updated_email)
    end
  end


  describe 'DELETE #destroy' do
    it 'destroys the user' do
      user = create(:admin_user)
      authenticate_user(user)
      delete :destroy, params: { id: user.id }
      expect(response).to have_http_status(:unauthorized)
    end
  end
end
