class Question::Choice < ApplicationRecord
  belongs_to :question

  validates_presence_of(:content)
  validates_presence_of(:correct)
end
