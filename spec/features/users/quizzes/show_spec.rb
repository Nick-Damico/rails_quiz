require "rails_helper"

RSpec.describe "User quiz show view", type: :feature do
  let(:user) { create(:user) }

  before { sign_in user }

  context "with quiz" do
    let!(:quiz) { create(:quiz, questions_count: 2) }
    before { visit quiz_path(quiz) }

    scenario "user can visit quiz show page" do
      expect(current_path).to eq(quiz_path(quiz))
    end

    scenario "user can view quiz details" do
      expect(page).to have_content(quiz.title)
      expect(page).to have_content(quiz.description)
    end

    scenario "user can see estimated time to complete" do
      within("p#quiz-duration") do
        expect(page).to have_content("01 minute")
      end
    end

    scenario "user can see question count" do
      within("p#quiz-question-count") do
        expect(page).to have_content("02 questions")
      end
    end

    context "without in-progress" do
      scenario "user can access start quiz button" do
        expect(page).to have_button('Start Quiz')
      end

      scenario "user can start quiz" do
        click_button "Start Quiz"

        answer_sheet = AnswerSheet.in_progress_answer_sheet_for(quiz:, user:)

        expect(current_path).to eq(answer_sheet_question_path(answer_sheet.next_incomplete_question))
        expect(page).to have_content(I18n.t('flash.answer_sheets.create.success'))
      end
    end

    context "with in-progress" do
      before do
        click_button "Start Quiz"
        visit quiz_path(quiz)
      end

      scenario "user can see resume quiz message" do
        within("div#resume-quiz") do
          expect(page).to have_content('Resume Quiz?')
        end
      end

      scenario "user can resume quiz" do
        answer_sheet = AnswerSheet.in_progress_answer_sheet_for(quiz:, user:)

        within("div#resume-quiz") do
          click_link "Yes"
        end

        expect(current_path).to eq(answer_sheet_question_path(answer_sheet.next_incomplete_question))
      end

      scenario "user can decide to not resume quiz" do
        within("div#resume-quiz") do
          click_button "No"
        end

        expect(page).to have_button "Start Quiz"
        expect(page).to_not have_content("div#resume-quiz")
      end
    end
  end
end
