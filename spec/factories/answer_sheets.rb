FactoryBot.define do
  factory :answer_sheet do
    quiz { create(:quiz) }
    user { create(:user) }
    grade { nil }
  end

  trait :with_grade do
    with_completed_quiz
    grade { 90.0 } # TODO: Actually grade this quiz
  end

  trait :with_completed_quiz do
    after(:create) do |answer_sheet|
      answer_sheet.prepare
      answer_sheet.answer_sheet_questions.each do |answer_sheet_question|
        answer = answer_sheet_question.question.choices.sample
        answer_sheet_question.update(answer:)
      end
    end
  end

  trait :with_zero_score do
    after(:create) do |answer_sheet|
      answer_sheet.prepare
      answer_sheet.answer_sheet_questions.each do |answer_sheet_question|
        answer = answer_sheet_question.question.choices.find { |choice| !choice.correct? }
        answer_sheet_question.update(answer:)
      end
    end
  end

  trait :with_perfect_score do
    after(:create) do |answer_sheet|
      answer_sheet.prepare
      answer_sheet.answer_sheet_questions.each do |answer_sheet_question|
        answer = answer_sheet_question.question.choices.find(&:correct)
        answer_sheet_question.update(answer:)
      end
    end
  end

  # Half of answers are correct
  trait :with_partial_score do
    quiz { create(:quiz, questions_count: 6) }

    after(:create) do |answer_sheet|
      answer_sheet.prepare

      answer_sheet_questions = answer_sheet.answer_sheet_questions
      half = answer_sheet_questions.size / 2

      answer_sheet_questions.each.with_index do |answer_sheet_question, index|
        answer =
          if index < half
            answer_sheet_question.question.choices.find(&:correct)
          else
            answer_sheet_question.question.choices.find { |choice| !choice.correct? }
          end

        answer_sheet_question.update(answer:)
      end
    end
  end
end
