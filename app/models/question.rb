class Question < ApplicationRecord
  belongs_to :quiz

  validates_presence_of(:quiz)
  validates_presence_of(:content)
end
