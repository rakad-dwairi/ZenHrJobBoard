require 'rails_helper'

RSpec.describe JobApplicationsController, type: :controller do
  # Create a helper method to authenticate the user for testing
  def authenticate_user(user)
    token = JWT.encode({ user_id: user.id }, Rails.application.secrets.secret_key_base)
    request.headers['Authorization'] = "Bearer #{token}"
  end

  describe 'GET #index' do
    context 'as a job seeker' do
      it 'returns job applications for the current user' do
        job_seeker = create(:user, role: 'jobseeker')
        authenticate_user(job_seeker)
        job_application = create(:job_application, user: job_seeker)
        get :index
        expect(response).to have_http_status(:success)
        expect(response.body).to include(job_application.to_json)
      end
    end

    context 'as an admin' do
      it 'returns all job applications' do
        admin = create(:admin_user)
        authenticate_user(admin)
        job_application = create(:job_application)
        get :index
        expect(response).to have_http_status(:success)
        expect(response.body).to include(job_application.to_json)
      end
    end
  end

  describe 'GET #show' do
    context 'as a job seeker' do
      it 'returns a job application for the current user' do
        job_seeker = create(:user, role: 'jobseeker')
        authenticate_user(job_seeker)
        job_application = create(:job_application, user: job_seeker)
        get :show, params: { id: job_application.id }
        expect(response).to have_http_status(:success)
        expect(response.body).to include(job_application.to_json)
      end
    end

    context 'as an admin' do
      it 'returns a job application for the current user and marks it as "Seen"' do
        admin = create(:admin_user)
        authenticate_user(admin)
        job_application = create(:job_application)
        get :show, params: { id: job_application.id }
        expect(response).to have_http_status(:success)
        job_application.reload
        expect(job_application.status).to eq('Seen')
      end
    end
  end

  describe 'POST #create' do
    it 'creates a new job application' do
      job_seeker = create(:user, role: 'jobseeker')
      authenticate_user(job_seeker)
      job_post = create(:job_post)
      job_application_params = { user_id: job_seeker.id, job_post_id: job_post.id }
      post :create, params: job_application_params
      expect(response).to have_http_status(:created)
    end
  end

  describe 'PUT #update' do
    it 'updates the job application' do
      job_seeker = create(:user)
      authenticate_user(job_seeker)
      job_application = create(:job_application, user: job_seeker)
      updated_status = 'Seen'
      put :update, params: { id: job_application.id, status: updated_status }
      job_application.reload
      expect(job_application.status).to eq(updated_status)
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the job application' do
      job_seeker = create(:admin_user)
      authenticate_user(job_seeker)
      job_application = create(:job_application, user: job_seeker)
      delete :destroy, params: { id: job_application.id }
      expect(response).to have_http_status(:unauthorized)
    end
  end
end
