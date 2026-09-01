class Admin::QuizPresenter
  attr_reader :quiz

  def initialize(quiz)
    @quiz = quiz
  end

  def to_model
    quiz
  end

  def field_names
    %i[username email created_on actions]
  end

  def title
    quiz.title
  end

  def created_on
    quiz.created_at.strftime("%Y-%m-%d")
  end

  def description
    quiz.description
  end
end
