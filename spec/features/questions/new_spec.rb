require "rails_helper"

RSpec.describe "Author Adds New Question", type: :feature do
  let(:author) { create(:user) }
  let(:quiz) { create(:quiz) }

  before do
    sign_in author
  end

  scenario "Author navigates to new Question form" do
    visit author_quiz_path(quiz)
    click_link "Add Question"

    expect(page).to have_content("Create Question")
  end

  scenario "Author successfully creates a question", js: true do
    question_attributes = attributes_for(:question, author:)
    visit new_quiz_question_path(quiz)

    fill_in "Question Text", with: question_attributes[:content]

    # form starts with two empty fields
    attributes_for_list(:choice, 2).each.with_index do |attributes, index|
      fill_in "Option", id: "question_choices_attributes_#{index}_content", with: attributes[:content]
      next if index != 0

      # mark first choice correct
      find("label[for='question_choices_attributes_#{index}_correct']").click
    end

    click_button "Create Question"

    expect(page).to have_content(I18n.t("flash.questions.create.success"))
    expect(page).to have_content(question_attributes[:content])
  end

  scenario "Author fails to create a question due to invalid input", js: true do
    visit new_quiz_question_path(quiz)

    # Text is required for valid question
    fill_in "Question Text", with: ""

    attributes_for_list(:choice, 2).each.with_index do |attributes, index|
      # click_button "Add"
      fill_in "Option", id: "question_choices_attributes_#{index}_content", with: attributes[:content]
      next if index != 0

      # mark first choice correct
      find("label[for='question_choices_attributes_#{index}_correct']").click
    end

    click_button "Create Question"

    expect(page).to have_content(I18n.t("flash.questions.create.error"))
  end

  scenario "form allows additional choice fields to be added", js: true do
    visit new_quiz_question_path(quiz)
    expected_choice_field_count = 2

    within("#question_choices_fields") do
      expect(all("input[type='text']").count).to eq(expected_choice_field_count) # Verify two empty choice fields
    end

    click_button "Add"

    within("#question_choices_fields") do
      expect(all("input[type='text']").count).to eq(expected_choice_field_count)
    end
  end

  scenario "a new question form starts with two blank choice fields" do
    visit new_quiz_question_path(quiz)

    within("#question_choices_fields") do
      expect(all("input[type='text']").count).to eq(2) # Verify two empty choice fields
    end
  end
end
