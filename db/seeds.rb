# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end



puts "SEEDING AUTHORS"

user_1 = FactoryBot.create(
  :user,
  username: "Sam Puppers",
  email: "sam_pups@quizit.com",
  password: "1234Sammy",
  password_confirmation: "1234Sammy"
)

puts "SEEDING QUIZZES & QUESTIONS"

quiz_1 = Quiz.create!(
  title: "Ruby Data Types",
  description: "Test your knowledge of fundamental Ruby data types and their practical applications. Perfect for Junior Ruby on Rails developers preparing for interviews or honing their skills.",
  author: user_1
)

quiz_1.questions.create!([
  {
    content: "What is a Symbol in Ruby?",
    choices_attributes: [
      { content: "An immutable string", correct: true },
      { content: "A mutable string", correct: false },
      { content: "A boolean value", correct: false }
    ]
  },
  {
    content: "What is the main difference between a String and a Symbol in Ruby?",
    choices_attributes: [
      { content: "Strings are mutable, Symbols are immutable", correct: true },
      { content: "Symbols are mutable, Strings are immutable", correct: false },
      { content: "There is no difference", correct: false }
    ]
  },
  {
    content: "What data type does the `nil` object represent?",
    choices_attributes: [
      { content: "NilClass", correct: true },
      { content: "Object", correct: false },
      { content: "String", correct: false }
    ]
  },
  {
    content: "Which of the following is a valid Integer in Ruby?",
    choices_attributes: [
      { content: "42", correct: true },
      { content: "'42'", correct: false },
      { content: "42.0", correct: false }
    ]
  },
  {
    content: "What is the data type of the value returned by `2.5 + 1`?",
    choices_attributes: [
      { content: "Float", correct: true },
      { content: "Integer", correct: false },
      { content: "String", correct: false }
    ]
  },
  {
    content: "What method converts a string to an integer in Ruby?",
    choices_attributes: [
      { content: "to_i", correct: true },
      { content: "to_int", correct: false },
      { content: "to_integer", correct: false }
    ]
  },
  {
    content: "What data type is a Range in Ruby?",
    choices_attributes: [
      { content: "Range", correct: true },
      { content: "Array", correct: false },
      { content: "Hash", correct: false }
    ]
  },
  {
    content: "What does the `is_a?` method do in Ruby?",
    choices_attributes: [
      { content: "Checks if an object is an instance of a specific class", correct: true },
      { content: "Converts an object to another class", correct: false },
      { content: "Checks if an object is nil", correct: false }
    ]
  },
  {
    content: "What is the result of `['a', 'b', 'c'].join(',')`?",
    choices_attributes: [
      { content: "'a,b,c'", correct: true },
      { content: "['a', 'b', 'c']", correct: false },
      { content: "'abc'", correct: false }
    ]
  },
  {
    content: "What does the `to_h` method do in Ruby?",
    choices_attributes: [
      { content: "Converts an enumerable to a hash", correct: true },
      { content: "Converts a string to a hash", correct: false },
      { content: "Converts a hash to a string", correct: false }
    ]
  }
])
