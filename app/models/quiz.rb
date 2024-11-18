class Quiz < ApplicationRecord
  belongs_to :author, class_name: "User"
  has_many :questions

  validates_presence_of :title
  validates_presence_of :author
end
