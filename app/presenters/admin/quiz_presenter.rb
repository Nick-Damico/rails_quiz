class Admin::QuizPresenter
  attr_reader :quiz

  delegate :to_model, :id, :hidden?, :published?, :hidden?, :title, :author, :description, to: :quiz

  def initialize(quiz)
    @quiz = quiz
  end

  def to_param
    String(quiz.id)
  end

  def field_names
    %i[username email created_on actions]
  end

  def author_name
    quiz.author.username
  end

  def created_on
    quiz.created_at.strftime("%Y-%m-%d")
  end
end
