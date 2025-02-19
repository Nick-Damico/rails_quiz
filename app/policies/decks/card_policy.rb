class Decks::CardPolicy < ApplicationPolicy
  class Scope
    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      @scope.all
    end
  end

  def new?
    user_is_owner?
  end

  def show?
    user_is_owner?
  end

  private

    def user_is_owner?
      Author::DeckPolicy.new(user, record.deck).user_is_owner?
    end
end
