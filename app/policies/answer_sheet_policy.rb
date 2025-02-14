class AnswerSheetPolicy < ApplicationPolicy
  def resume?
    user_is_owner?
  end

  def pause?
    user_is_owner?
  end

  def show?
    user_is_owner?
  end

  def create?
    user_is_owner?
  end

  def destroy?
    user_is_owner?
  end
end
