class User < ApplicationRecord
  has_many :authored_decks, class_name: "Deck", foreign_key: :author_id
  has_many :authored_quizzes, class_name: "Quiz", foreign_key: :author_id
  has_many :study_plans

  has_many :user_decks
  has_many :decks, through: :user_decks

  validates_presence_of(:username)
  validates_uniqueness_of(:username)

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
