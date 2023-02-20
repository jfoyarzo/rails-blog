class Ability
  include CanCan::Ability

  def initialize(user)
    return unless user.present?

    can(:read, :all)

    can :create, Post
    can :create, Comment

    can(%i[destroy], Post, user:)
    can(%i[destroy], Comment, user:)

    return unless user.role == 'admin'

    can :destroy, Post
    can :destroy, Comment
  end
end
