require 'swagger_helper'

RSpec.describe 'Authentication API', type: :request do
  describe 'POST /auth/login' do
    it 'logs in a user' do
      user = User.create(email: 'admin@job-board.com', password: '123456789')
      post '/auth/login', params: { email: 'admin@job-board.com', password: '123456789' }
      expect(response).to have_http_status(:ok)
      expect(json['token']).not_to be_nil
    end
  end

  describe 'POST /register' do
    it 'registers a new user' do
      post '/register', params: { email: 'admin@job-board.com', password: '123456789', role: 'jobseeker' }
      expect(response).to have_http_status(:created)
      expect(json['email']).to eq('admin@job-board.com')
      expect(json['role']).to eq('jobseeker')
    end
  end
end
