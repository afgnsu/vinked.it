class Ability
  include CanCan::Ability

  def initialize(user)
    unless user.blank?
      if user.admin?
        # Admins
        can :manage, :all
      elsif user.premium?
        # Premium subscription users
        can [:index, :show, :update, :profile], User
        can [:index, :show, :create], Club
        can [:index, :show, :create, :update, :destroy], Vink

        cannot [:update, :destroy, :maintain], Club
        cannot [:index, :show, :create, :update, :destroy], Country
        cannot [:index, :show, :create, :update, :destroy], League
      elsif user.basic?
        # Basic subscription users
        can [:index, :show, :update, :profile], User
        can [:index, :show], Club
        can [:index, :show, :create, :update, :destroy], Vink

        cannot [:create, :destroy], User
        cannot [:create, :update, :destroy, :maintain], Club
        cannot [:index, :show, :create, :update, :destroy], Country
        cannot [:index, :show, :create, :update, :destroy], League
      end
    else
      # Unregistered users
      cannot :manage, :all
    end
  end
end
