# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    if user.role == 'jobseeker'
        can :read, JobPost  # Job Seekers can read job posts
        can :create, JobApplication  # Job Seekers can apply to jobs
        can :update, JobApplication, :user_id => user.id  # Job Seekers can update their applications
        can :read, JobApplication, :user_id => user.id  # Job Seekers can view their applications
        can :read, User, :user_id => user.id # Job Seekers can view their User Profile
        can :update, User, :user_id => user.id # Job Seekers can update their User Profile
        cannot :read, User
    end

    if user.role == 'admin'
        can :manage, JobPost  # Admin Users can manage job posts
        can :read, JobApplication  # Admin Users can view job applications
        can :update, JobApplication  # Admin Users can update job applications
        can :manage, User # Admin Users can manage job applications
        cannot :destroy, [User, JobApplication]  # Admin Users cannot destroy users or job applications
    end

  end
end
