class AnswerSheet::Grader
  def initialize(answer_sheet)
    validate_answer_sheet(answer_sheet)

    @answer_sheet = answer_sheet
  end

  def grade
    @answer_sheet.update(grade: correct_answer_count / total_question_count * 100)
  end

  private

  def validate_answer_sheet(answer_sheet)
    raise ArgumentError, "Answer sheet cannot be nil or empty" unless answer_sheet.present?
    raise ArgumentError, "Expected an AnswerSheet, received #{answer_sheet.class}" unless answer_sheet.is_a?(AnswerSheet)
    raise ArgumentError, "Answer sheet must be complete" unless answer_sheet.completed?
  end

  def correct_answer_count
    @correct_answer_count ||= @answer_sheet.answers.count(&:correct)
  end

  def total_question_count
    @answer_sheet.answer_sheet_questions.count.to_f
  end
end
