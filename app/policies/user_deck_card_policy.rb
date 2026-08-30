class UserDeckCardPolicy < ApplicationPolicy
  class Scope < ApplicationPolicy::Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      @scope.joins(:user_deck).where(user_decks: { user_id: @user.id })
    end
  end

  def show?
    UserDeckPolicy.new(user, record.user_deck).user_is_owner?
  end

  def update?
    UserDeckPolicy.new(user, record.user_deck).user_is_owner?
  end
end
