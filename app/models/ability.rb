class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, :all

    if user && user.has_role?(:admin)
      can :access, :rails_admin
      can :dashboard

      if user.has_role?(:master_wizard)
        can :manage, :all
      end
    end
  end
end
