class AnswerSheet::Grader
  PERCENTAGE_MULTIPLIER = 100

  def initialize(answer_sheet)
    raise ArgumentError, "Answer sheet cannot be nil or empty" unless answer_sheet.present?
    raise ArgumentError, "Expected an AnswerSheet, received #{answer_sheet.class}" unless answer_sheet.is_a?(AnswerSheet)

    @answer_sheet = answer_sheet
  end

  def grade
    grade = (correct_answer_count / total_question_count) * PERCENTAGE_MULTIPLIER

    @answer_sheet.update(grade:)
  end

  private

  def correct_answer_count
    @correct_answer_count ||= @answer_sheet.answers.count(&:correct)
  end

  def total_question_count
    @answer_sheet.answer_sheet_questions.count.to_f
  end
end
