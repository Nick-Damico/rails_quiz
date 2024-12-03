class Question < ApplicationRecord
  belongs_to :quiz
  has_many :choices, class_name: "Question::Choice"

  validates_presence_of(:quiz)
  validates_presence_of(:content)
end
