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
        can [:index, :show, :create, :update, :destroy], Vink

        cannot [:destroy], User
        cannot [:create, :update, :destroy], User
        cannot [:index, :show, :create, :update, :destroy], Country
        cannot [:index, :show, :create, :update, :destroy], League
      elsif user.premium?
        # Premium subscription users
        can [:index, :show, :update], User
        can [:index, :show, :create], Club
        can [:index, :show, :create, :update, :destroy], Vink

        cannot [:destroy], User
        cannot [:update, :destroy], User
        cannot [:index, :show, :create, :update, :destroy], Country
        cannot [:index, :show, :create, :update, :destroy], League
      end
    else
      # Unregistered users
      cannot :manage, :all
    end
  end
end
