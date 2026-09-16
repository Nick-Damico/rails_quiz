class Admin::QuizPresenter
  attr_reader :quiz

  def initialize(quiz)
    @quiz = quiz
  end

  def to_model
    quiz
  end

  def to_param
    String(quiz.id)
  end

  def field_names
    %i[username email created_on actions]
  end

  def title
    quiz.title
  end

  def author
    quiz.author
  end

  def author_name
    quiz.author.username
  end

  def created_on
    quiz.created_at.strftime("%Y-%m-%d")
  end

  def description
    quiz.description
  end

  def hidden?
    quiz.hidden?
  end

  def published?
    quiz.published?
  end
end
