class User < ApplicationRecord
  has_many :authored_decks, class_name: "Deck", foreign_key: :author_id
  has_many :authored_quizzes, class_name: "Quiz", foreign_key: :author_id
  has_many :study_plans

  has_many :user_decks
  has_many :decks, through: :user_decks

  has_one_attached :avatar

  enum :rank, {
    curious_mind: 0,
    dedicated_learner: 1,
    study_warrior: 2,
    quiz_master: 3,
    knowledge_sage: 4,
    grand_scholar: 5
  }

  validates_presence_of(:username)
  validates_uniqueness_of(:username)

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
end
