class Author::QuizPolicy < ApplicationPolicy
  class Scope
    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      Quiz.where(author: @user)
    end
  end

  def new?
    create?
  end

  def edit?
    update?
  end

  def update?
    user_is_author?(record.author_id)
  end

  def create?
    user_is_author?(record.author_id)
  end

  def show?
    user_is_author?(record.author_id)
  end

  def destroy?
    user_is_author?(record.author_id)
  end

  private

  def user_is_author?(author_id)
    user.id == author_id
  end
end
