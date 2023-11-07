require 'rails_helper'

RSpec.describe 'Users API', type: :request do
  describe 'GET /users' do
    it 'returns a list of users' do
      create_list(:user, 5)
      get '/users'
      expect(response).to have_http_status(:ok)
      expect(json.length).to eq(5)
    end
  end

  describe 'POST /users' do
    it 'creates a new user' do
      post '/users', params: { email: 'newuser@gmail.com', password: 'password', role: 'jobseeker' }
      expect(response).to have_http_status(:created)
      expect(json['email']).to eq('newuser@gmail.com')
      expect(json['role']).to eq('jobseeker')
    end
  end

  describe 'GET /users/:id' do
    it 'returns a specific user' do
      user = create(:user)
      get "/users/#{user.id}"
      expect(response).to have_http_status(:ok)
      expect(json['email']).to eq(user.email)
    end
  end

  describe 'PUT /users/:id' do
    it 'updates a user' do
      user = create(:user)
      put "/users/#{user.id}", params: { email: 'updatedemail@gmail.com' }
      expect(response).to have_http_status(:ok)
      expect(json['email']).to eq('updatedemail@gmail.com')
    end
  end

  describe 'DELETE /users/:id' do
    it 'deletes a user' do
      user = create(:user)
      delete "/users/#{user.id}"
      expect(response).to have_http_status(:no_content)
    end
  end

  describe 'GET /get-current-user' do
    it 'returns the current user' do
      user = create(:user)
      auth_headers = user.create_new_auth_token
      get '/get-current-user', headers: auth_headers
      expect(response).to have_http_status(:ok)
      expect(json['email']).to eq(user.email)
    end
  end
end
