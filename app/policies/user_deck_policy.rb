class UserDeckPolicy < ApplicationPolicy
  class Scope
    def initialize(user, scope)
      @user, @scope = user, scope
    end

    def resolve
      @scope.where(user_id: @user.id)
    end
  end

  def show?
    user_is_owner?
  end

  def create?
    user_is_owner?
  end

  def update?
    user_is_owner?
  end
end
