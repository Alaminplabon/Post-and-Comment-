class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, Post

    return unless user.present?  # additional permissions for logged in users (they can read their own posts)
    can :manage, Post, user: user
    can :manage, Comment, user: user

  end
end