class Ability
  include CanCan::Ability

  def initialize(user)
    if user
      can :manage, Project, user: user
      can :manage, Task, user: user
      can :manage, Comment, user: user
    end
  end
end
