class Decks::CardPolicy < ApplicationPolicy
  # class Scope
  #   def initialize(user, scope)
  #     @user = user
  #     @scope = scope
  #   end

  #   def resolve
  #     @scope.all
  #   end
  # end

  def show?
    user_is_owner?
  end

  def new?
    create?
  end

  def create?
    user_is_owner?
  end

  def edit?
    update?
  end

  def update?
    user_is_owner?
  end

  def destroy?
    user_is_owner?
  end

  private

    def user_is_owner?
      Author::DeckPolicy.new(user, record.deck).user_is_owner?
    end
end
