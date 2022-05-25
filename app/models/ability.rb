# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.admin_role?
      can :manage, :all
    end

    if user.worker_role?
      can :manage, Production
      can :manage, Work
      can :manage, Execution
    end
  end
end
