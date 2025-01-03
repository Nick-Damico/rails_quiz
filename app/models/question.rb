class Question < ApplicationRecord
  belongs_to :quiz
  has_many :choices, class_name: "Question::Choice", dependent: :destroy

  validates_presence_of(:quiz)
  validates_presence_of(:content)
  validate :validate_number_of_choices
  validate :validate_correct_choice

  accepts_nested_attributes_for :choices

  private

  def validate_number_of_choices
    return unless choices.size <= 1

    errors.add(:base, "must have at least 2 choices")
  end

  def validate_correct_choice
    return unless choices.none?(&:correct)

    errors.add(:base, "must have one choice marked as correct")
  end
end
