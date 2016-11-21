class Ability
  include CanCan::Ability

  def initialize(user = nil)
    can :manage, :all

    # Game
    cannot [:create, :new], Game
    can [:create, :new], Game if Game.current.nil?
    cannot [:cancel, :score], Game
    can [:cancel, :score], Game do |game|
      game.state == 'on'
    end
  end
end
