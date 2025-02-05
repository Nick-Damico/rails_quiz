class QuestionPolicy < ApplicationPolicy
  def show?
    user_is_author?
  end

  def new?
    create?
  end

  def create?
    user_is_author?
  end

  def edit?
    update?
  end

  def update?
    user_is_author?
  end

  def destroy?
    user_is_author?
  end

  private

  def user_is_author?
    user.id == record.quiz.author_id
  end
end
