class Ability
  include CanCan::Ability

  def initialize(user)
    unless user.blank?
      if user.admin?
        # Admins
        can :manage, :all
      elsif user.basic?
        # Basic subscription users
        can [:index, :show, :update], User
        can [:index, :show], Club

        cannot [:destroy], User
        cannot [:create, :update, :destroy], User
      elsif user.premium?
        # Premium subscription users
        can [:index, :show, :update], User
        can [:index, :show, :create], Club

        cannot [:destroy], User
        cannot [:update, :destroy], User
      end
    else
      # Unregistered users
      cannot :manage, :all
    end
  end
end
