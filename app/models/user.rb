class User < ApplicationRecord
  has_many :authored_quizzes, class_name: "Quiz", foreign_key: :author_id
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates_presence_of(:username)
  validates_uniqueness_of(:username)
end
