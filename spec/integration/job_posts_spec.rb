require 'rails_helper'

RSpec.describe 'Job Posts API', type: :request do
  describe 'GET /job_posts' do
    it 'returns a list of job posts' do
      create_list(:job_post, 5)
      get '/job_posts'
      expect(response).to have_http_status(:ok)
      expect(json.length).to eq(5)
    end
  end

  describe 'POST /job_posts' do
    it 'creates a new job post' do
      user = create(:user, role: 'employer')
      auth_headers = user.create_new_auth_token
      post '/job_posts', params: { title: 'Software Engineer', description: 'Mid-level position' }, headers: auth_headers
      expect(response).to have_http_status(:created)
      expect(json['title']).to eq('Software Engineer')
      expect(json['description']).to eq('Mid-level position')
    end
  end

  describe 'GET /job_posts/:id' do
    it 'returns a specific job post' do
      job_post = create(:job_post)
      get "/job_posts/#{job_post.id}"
      expect(response).to have_http_status(:ok)
      expect(json['title']).to eq(job_post.title)
    end
  end

  describe 'PUT /job_posts/:id' do
    it 'updates a job post' do
      job_post = create(:job_post)
      user = create(:user, role: 'employer')
      auth_headers = user.create_new_auth_token
      put "/job_posts/#{job_post.id}", params: { title: 'Updated Title' }, headers: auth_headers
      expect(response).to have_http_status(:ok)
      expect(json['title']).to eq('Updated Title')
    end
  end

  describe 'DELETE /job_posts/:id' do
    it 'deletes a job post' do
      job_post = create(:job_post)
      user = create(:user, role: 'employer')
      auth_headers = user.create_new_auth_token
      delete "/job_posts/#{job_post.id}", headers: auth_headers
      expect(response).to have_http_status(:no_content)
    end
  end
end
