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

        cannot [:destroy], User
      elsif user.premium?
        # Premium subscription users
        can [:index, :show, :update], User

        cannot [:destroy], User
      end
    else
      # Unregistered users
      cannot :manage, :all
    end
  end
end
