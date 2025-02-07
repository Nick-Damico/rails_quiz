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
    user_is_author?
  end

  def create?
    user_is_author?
  end

  def show?
    user_is_author?
  end

  def destroy?
    user_is_author?
  end

  def user_is_author?
    user.id == record.author_id
  end
end
