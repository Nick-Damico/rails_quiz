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

  def user_is_author?
    QuizPolicy.new(user, record.quiz).user_is_owner?
  end
end
