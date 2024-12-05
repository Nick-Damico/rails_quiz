class Question::Choice < ApplicationRecord
  belongs_to :question

  validates_presence_of(:question)
  validates_presence_of(:content)
  validates :correct, inclusion: [ true, false ]
end
