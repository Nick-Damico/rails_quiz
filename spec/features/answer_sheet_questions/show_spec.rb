require "rails_helper"

RSpec.describe "AnswerSheetQuestion show page", type: :feature do
  let(:user) { create(:user) }
  let(:quiz) { create(:quiz, questions_count: 4) }
  let(:answer_sheet) { create(:answer_sheet, quiz:, user:)  }

  before do
    sign_in user

    answer_sheet.prepare
  end

  context "page contents and interactions" do
    let(:answer_sheet_question) { answer_sheet.answer_sheet_questions.first }

    before do
      visit answer_sheet_question_path(answer_sheet_question)
    end

    scenario "user can see the current question number" do
      expect(page).to have_content("Question 01/04")
    end

    scenario "user can see the question" do
      expect(page).to have_content(answer_sheet_question.question.content)
    end

    scenario "user can see the answer choices for the question" do
      answer_sheet_question.question.choices.each do |choice|
        expect(page).to have_content("#{choice.content}")
      end
    end

    scenario "user can pause quiz" do
      click_link "Pause"

      expect(current_path).to eq(quiz_path(quiz))
      expect(page).to have_content(I18n.t("flash.answer_sheets.pause.success"))
    end

    scenario "user can answer question", js: true do
      choice = answer_sheet_question.question.choices.first
      # mark first choice as answer
      find("label[for='answer_sheet_question_answer_id_#{choice.id}']").click

      click_button "Next"

      expect(page).to have_content(I18n.t("flash.answer_sheet_questions.update.success"))
    end
  end

  scenario "user can complete a full a quiz", js: true do
    answer_sheet.answer_sheet_questions.each.with_index(1) do |answer_sheet_question, index|
      last_question = index == answer_sheet.answer_sheet_questions.count
      choice = answer_sheet_question.question.choices.first

      visit answer_sheet_question_path(answer_sheet_question)

      find("label[for='answer_sheet_question_answer_id_#{choice.id}']").click

      if last_question
        click_button "Finish"
      else
        click_button "Next"
      end
    end

    expect(page).to have_current_path(answer_sheet_path(answer_sheet))
  end
end
