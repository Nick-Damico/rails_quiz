class AnswerSheetQuestionPolicy < ApplicationPolicy
  def show?
    belongs_to_user?
  end

  def update?
    belongs_to_user?
  end

  def belongs_to_user?
    AnswerSheetPolicy.new(user, record.answer_sheet).belongs_to_user?
  end
end
