require 'rails_helper'

RSpec.describe JobPostsController, type: :controller do
  # Create a helper method to authenticate the user for testing
  def authenticate_user(user)
    token = JWT.encode({ user_id: user.id }, Rails.application.secrets.secret_key_base)
    request.headers['Authorization'] = "Bearer #{token}"
  end

  describe 'GET #index' do
    it 'returns a success response' do
      user = create(:user) # Create a user for the job post
      authenticate_user(user)
      job_post = create(:job_post, user: user)
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      user = create(:user)
      authenticate_user(user)
      job_post = create(:job_post, user: user)
      get :show, params: { id: job_post.id }
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST #create' do
    it 'creates a new job post' do
      user = create(:admin_user)
      authenticate_user(user)
      job_post_params = { title: 'New Job', description: 'Job description' }
      post :create, params: job_post_params
      expect(response).to have_http_status(:created)
    end
  end

  describe 'PUT #update' do
    it 'updates the job post' do
      user = create(:admin_user)
      authenticate_user(user)
      job_post = create(:job_post, user: user)
      updated_title = 'Updated Job'
      put :update, params: { id: job_post.id, title: updated_title }
      job_post.reload
      expect(job_post.title).to eq(updated_title)
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the job post' do
      user = create(:admin_user)
      authenticate_user(user)
      job_post = create(:job_post, user: user)
      delete :destroy, params: { id: job_post.id }
      expect(response).to have_http_status(:no_content)
    end
  end
end
