class AnswerSheetPolicy < ApplicationPolicy
  def resume?
    belongs_to_user?
  end

  def pause?
    belongs_to_user?
  end

  def show?
    belongs_to_user?
  end

  def create?
    belongs_to_user?
  end

  def destroy?
    belongs_to_user?
  end

  def belongs_to_user?
    user.id == record.user_id
  end
end
