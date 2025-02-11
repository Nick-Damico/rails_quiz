# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.2].define(version: 2025_02_11_211317) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "answer_sheet_questions", force: :cascade do |t|
    t.bigint "answer_sheet_id", null: false
    t.bigint "question_id", null: false
    t.bigint "answer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["answer_id"], name: "index_answer_sheet_questions_on_answer_id"
    t.index ["answer_sheet_id"], name: "index_answer_sheet_questions_on_answer_sheet_id"
    t.index ["question_id"], name: "index_answer_sheet_questions_on_question_id"
  end

  create_table "answer_sheets", force: :cascade do |t|
    t.bigint "quiz_id", null: false
    t.bigint "user_id", null: false
    t.decimal "grade", precision: 5, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["quiz_id"], name: "index_answer_sheets_on_quiz_id"
    t.index ["user_id"], name: "index_answer_sheets_on_user_id"
  end

  create_table "cards", force: :cascade do |t|
    t.text "front", null: false
    t.text "back", null: false
    t.bigint "deck_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["deck_id"], name: "index_cards_on_deck_id"
  end

  create_table "decks", force: :cascade do |t|
    t.string "title", null: false
    t.text "description"
    t.bigint "author_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_id"], name: "index_decks_on_author_id"
  end

  create_table "question_choices", force: :cascade do |t|
    t.text "content"
    t.boolean "correct", default: false, null: false
    t.bigint "question_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["question_id"], name: "index_question_choices_on_question_id"
  end

  create_table "questions", force: :cascade do |t|
    t.bigint "quiz_id", null: false
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["quiz_id"], name: "index_questions_on_quiz_id"
  end

  create_table "quizzes", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "author_id", null: false
    t.index ["author_id"], name: "index_quizzes_on_author_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "answer_sheet_questions", "answer_sheets"
  add_foreign_key "answer_sheet_questions", "question_choices", column: "answer_id"
  add_foreign_key "answer_sheet_questions", "questions"
  add_foreign_key "answer_sheets", "quizzes"
  add_foreign_key "answer_sheets", "users"
  add_foreign_key "cards", "decks"
  add_foreign_key "decks", "users", column: "author_id"
  add_foreign_key "question_choices", "questions"
  add_foreign_key "questions", "quizzes"
  add_foreign_key "quizzes", "users", column: "author_id"
end
