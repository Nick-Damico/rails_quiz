require "rails_helper"

RSpec.describe Admin::QuizzesController, type: :request do
  let(:admin) { create(:user, :with_admin) }
  let(:user) { create(:user) }
  let(:quiz) { create(:quiz, author: user) }

  describe "GET /admin/quizzes/:id/edit" do
    context "when not authenticated" do
      before { sign_in user }

      it "redirects to root url with an access denied message" do
        get edit_admin_quiz_path(create(:quiz))

        expect(response).to redirect_to(root_url)
        expect(flash[:alert]).to eq("Access denied.")
      end
    end

    context "when authenticated as admin" do
      before do
        sign_in admin
      end

      it "responds successfully" do
        get edit_admin_quiz_path(quiz)

        expect(response).to have_http_status(:success)
      end
    end
  end

  describe "PATCH /admin/quizzes/:id" do
    context "when not authenticated" do
      before { sign_in user }

      it "redirects to root url with an access denied message" do
        get edit_admin_quiz_path(create(:quiz))

        expect(response).to redirect_to(root_url)
        expect(flash[:alert]).to eq("Access denied.")
      end
    end

    context "when authenticated as admin" do
      before do
        sign_in admin
      end

      context "with valid params" do
        it "redirects to admin dashboard" do
          patch admin_quiz_path(quiz), params: { quiz: { title: "101 computer science" } }

          expect(response).to redirect_to(admin_dashboard_url(tab: "quiz"))
        end

        it "updates the information" do
          patch admin_quiz_path(quiz), params: { quiz: { title: "101 computer science", description: "learn fundamentals" } }

          quiz.reload
          expect(quiz.title).to eq("101 computer science")
          expect(quiz.description).to eq("learn fundamentals")
        end

        context "when deactivating a quiz" do
          it "sets the quiz to hidden & unpublishes it" do
            quiz = create(:quiz, :published)
            patch admin_quiz_path(quiz), params: { quiz: { hidden: "1" } }

            quiz.reload
            expect(quiz).to be_hidden
            expect(quiz).not_to be_published
          end
        end
      end

      context "with invalid params" do
        it "responds with status code of unprocessable content" do
          patch admin_quiz_path(quiz), params: { quiz: { title: "" } }

          expect(response).to have_http_status(:unprocessable_content)
        end

        it "does not update the quiz information" do
          original_title = quiz.title

          patch admin_quiz_path(quiz), params: { quiz: { title: "" } }

          expect(quiz.reload.title).to eq(original_title)
        end
      end
    end
  end
end
