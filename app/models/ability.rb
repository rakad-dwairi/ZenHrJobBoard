# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    if user.role == 'jobseeker'
      jobseeker_abilities(user)
    elsif user.role == 'admin'
      admin_abilities
    end
  end

  private

  def jobseeker_abilities(user)
    can :read, JobPost
    can :create, JobApplication
    can [:read, :update], JobApplication, user_id: user.id
    can [:read, :update], User, id: user.id
    cannot :read, User
  end

  def admin_abilities
    can :manage, JobPost
    can :read, JobApplication
    can :update, JobApplication
    can :manage, User
    cannot :destroy, [User, JobApplication]
  end
end
