require 'rails_helper'

RSpec.describe 'Job Applications API', type: :request do
  describe 'GET /job_applications' do
    it 'returns a list of job applications' do
      create_list(:job_application, 5)
      get '/job_applications'
      expect(response).to have_http_status(:ok)
      expect(json.length).to eq(5)
    end
  end

  describe 'POST /job_applications' do
    it 'creates a new job application' do
      user = create(:user, role: 'jobseeker')
      auth_headers = user.create_new_auth_token
      job_post = create(:job_post)
      post '/job_applications', params: { job_post_id: job_post.id }, headers: auth_headers
      expect(response).to have_http_status(:created)
      expect(json['user_id']).to eq(user.id)
      expect(json['job_post_id']).to eq(job_post.id)
    end
  end

  describe 'GET /job_applications/:id' do
    it 'returns a specific job application' do
      job_application = create(:job_application)
      get "/job_applications/#{job_application.id}"
      expect(response).to have_http_status(:ok)
      expect(json['user_id']).to eq(job_application.user_id)
    end
  end

  describe 'PUT /job_applications/:id' do
    it 'updates a job application' do
      job_application = create(:job_application)
      user = create(:user, role: 'jobseeker')
      auth_headers = user.create_new_auth_token
      put "/job_applications/#{job_application.id}", headers: auth_headers
      expect(response).to have_http_status(:ok)
      expect(json['status']).to eq('accepted')
    end
  end

  describe 'DELETE /job_applications/:id' do
    it 'deletes a job application' do
      job_application = create(:job_application)
      user = create(:user, role: 'jobseeker')
      auth_headers = user.create_new_auth_token
      delete "/job_applications/#{job_application.id}", headers: auth_headers
      expect(response).to have_http_status(:no_content)
    end
  end
end
