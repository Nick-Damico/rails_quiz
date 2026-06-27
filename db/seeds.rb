# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

return unless Rails.env.development?

puts "SEEDING AUTHORS"

user_1 = FactoryBot.create(
  :user,
  bio: "Junior Ruby on Rails developer that is eager to learn and grow in the field of software development.",
  username: "Sam Puppers",
  email: "sam_pups@quizit.com",
  rank: :study_warrior,
  password: "1234Sammy",
  password_confirmation: "1234Sammy"
)

user_2 = FactoryBot.create(
  :user,
  username: Faker::Artist.name,
  email: Faker::Internet.email(domain: 'gmail.com'),
  bio: "Comic book enthusiast and aspiring physician that loves learning.",
  rank: :dedicated_learner,
  password: "usr2Faker",
  password_confirmation: "usr2Faker"
)

user_1.avatar.attach(io: File.open(Rails.root.join("spec", "fixtures", "files", "avatar_1.jpg")),
                     filename: "avatar_1.jpg",
                     content_type: "image/jpeg")

user_2.avatar.attach(io: File.open(Rails.root.join("spec", "fixtures", "files", "avatar_2.jpg")),
                     filename: "avatar_2.jpg",
                     content_type: "image/jpeg")

load Rails.root.join("db", "seeds", "category.rb")
load Rails.root.join("db", "seeds", "quizzes.rb")
load Rails.root.join("db", "seeds", "flashcard_decks.rb")
