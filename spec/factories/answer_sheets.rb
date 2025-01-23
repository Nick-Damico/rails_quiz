FactoryBot.define do
  factory :answer_sheet do
    quiz { create(:quiz) }
    user { create(:user) }
    grade { nil }
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

  trait :with_grade do
    with_completed_quiz
    grade { 90.0 } # TODO: Actually grade this quiz
  end
end
