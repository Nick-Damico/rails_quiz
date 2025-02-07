class Questions::ChoicePolicy < ApplicationPolicy
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
    QuestionPolicy.new(user, record.question).user_is_author?
  end
end
