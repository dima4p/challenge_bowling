class Ability
  include CanCan::Ability

  def initialize(user = nil)
    can :manage, :all
  end
end
