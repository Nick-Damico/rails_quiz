class StudyPlan < ApplicationRecord
  belongs_to :user

  validates :name, presence: true
  validates :name, uniqueness: { case_sensitive: true }
  validates :description, presence: true
end
