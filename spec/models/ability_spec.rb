# spec/models/ability_spec.rb

require 'rails_helper'

RSpec.describe Ability do
  subject(:job_seeker_ability) { described_class.new(jobseeker) }
  subject(:admin_ability) { described_class.new(admin) }

  let(:jobseeker) { create(:job_seeker_user) }
  let(:admin) { create(:admin_user) }
  let(:job_post) { create(:job_post) }
  let(:job_application) { create(:job_application, user: jobseeker) }
  let(:other_user) { create(:job_seeker_user) }

  context 'when the user is a job seeker' do
    before do
      jobseeker # Authenticate the job seeker
    end

    it 'can read job posts' do
      expect(job_seeker_ability.can?(:read, job_post)).to be_truthy
    end

    it 'can create job applications' do
      expect(job_seeker_ability.can?(:create, JobApplication)).to be_truthy
    end

    it 'can update its own job applications' do
      expect(job_seeker_ability.can?(:update, job_application)).to be_truthy
    end

    it 'can read its own job applications' do
      expect(job_seeker_ability.can?(:read, job_application)).to be_truthy
    end

    it 'cannot read other user profiles' do
      expect(job_seeker_ability.cannot?(:read, other_user)).to be_truthy
    end
  end

  context 'when the user is an admin' do
    before do
      admin # Authenticate the admin
    end

    it 'can manage job posts' do
      expect(admin_ability.can?(:manage, job_post)).to be_truthy
    end

    it 'can read job applications' do
      expect(admin_ability.can?(:read, job_application)).to be_truthy
    end

    it 'can update job applications' do
      expect(admin_ability.can?(:update, job_application)).to be_truthy
    end

    it 'can manage users' do
      expect(admin_ability.can?(:manage, User)).to be_truthy
    end

    it 'cannot destroy users' do
      expect(admin_ability.cannot?(:destroy, User)).to be_truthy
    end

    it 'cannot destroy job applications' do
      expect(admin_ability.cannot?(:destroy, JobApplication)).to be_truthy
    end
  end
end
