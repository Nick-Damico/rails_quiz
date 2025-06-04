class StudyPlan < ApplicationRecord
  belongs_to :user

  has_many :study_plan_decks, dependent: :destroy
  has_many :decks, through: :study_plan_decks

  has_many :study_plan_quizzes, dependent: :destroy
  has_many :quizzes, through: :study_plan_quizzes

  validates :name, presence: true
  validates :description, presence: true
end
