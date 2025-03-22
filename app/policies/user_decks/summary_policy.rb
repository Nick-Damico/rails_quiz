class UserDecks::SummaryPolicy < ApplicationPolicy
  class Scope; end

  def show?
    UserDeckPolicy.new(user, record).user_is_owner?
  end
end
