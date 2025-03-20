class UserDeckPolicy < ApplicationPolicy
  class Scope; end

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
