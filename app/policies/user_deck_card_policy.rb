class UserDeckCardPolicy < ApplicationPolicy
  class Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end

  def show?
    UserDeckPolicy.new(user, record.user_deck).user_is_owner?
  end
end
