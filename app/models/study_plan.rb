class StudyPlan < ApplicationRecord
  belongs_to :user

  has_many :study_plan_decks, dependent: :destroy
  has_many :study_plan_quizzes, dependent: :destroy

  validates :name, presence: true
  validates :description, presence: true
end
