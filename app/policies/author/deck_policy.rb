class Author::DeckPolicy < ApplicationPolicy
  class Scope
    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      @scope.all
    end
  end

  def show?
    user.id == record.author_id
  end

  def new?
    create?
  end

  def create?
    user_is_owner?
  end

  private
end
