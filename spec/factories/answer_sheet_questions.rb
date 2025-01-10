FactoryBot.define do
  factory :answer_sheet_question do
    answer_sheet { create(:answer_sheet) }

    after(:build) do |answer_sheet_question, _evaluator|
      answer_sheet_question.question ||= answer_sheet_question.answer_sheet.quiz.questions.first
    end
  end
end
