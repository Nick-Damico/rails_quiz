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

user_2 = FactoryBot.create(
  :user,
  username: Faker::Artist.name,
  email: Faker::Internet.email(domain: 'gmail.com'),
  password: "usr2Faker",
  password_confirmation: "usr2Faker"
)

puts "SEEDING QUIZZES & QUESTIONS"

quiz_1 = Quiz.create!(
  title: "Ruby Data Types",
  description: "Test your knowledge of fundamental Ruby data types and their practical applications. Perfect for Junior Ruby on Rails developers preparing for interviews or honing their skills.",
  author: user_1
)

quiz_2 = Quiz.create!(
  title: "Fundamentals of Data Structures",
  description: "Assess your understanding of essential data structures and their applications. This quiz is designed for junior developers looking to strengthen their foundational knowledge.",
  author: user_1
)

quiz_1.questions.create!([
  {
    content: "What is a Symbol in Ruby?",
    choices_attributes: [
      { content: "A mutable string", correct: false },
      { content: "An immutable string", correct: true },
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
      { content: "Object", correct: false },
      { content: "String", correct: false },
      { content: "NilClass", correct: true }
    ]
  },
  {
    content: "Which of the following is a valid Integer in Ruby?",
    choices_attributes: [
      { content: "'42'", correct: false },
      { content: "42", correct: true },
      { content: "42.0", correct: false }
    ]
  },
  {
    content: "What is the data type of the value returned by `2.5 + 1`?",
    choices_attributes: [
      { content: "Integer", correct: false },
      { content: "String", correct: false },
      { content: "Float", correct: true }
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
      { content: "Array", correct: false },
      { content: "Range", correct: true },
      { content: "Hash", correct: false }
    ]
  },
  {
    content: "What does the `is_a?` method do in Ruby?",
    choices_attributes: [
      { content: "Converts an object to another class", correct: false },
      { content: "Checks if an object is an instance of a specific class", correct: true },
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
      { content: "Converts a string to a hash", correct: false },
      { content: "Converts a hash to a string", correct: false },
      { content: "Converts an enumerable to a hash", correct: true }
    ]
  }
])

quiz_2.questions.create!([
  {
    content: "What is the time complexity of accessing an element by index in an array?",
    choices_attributes: [
      { content: "O(1)", correct: true },
      { content: "O(n)", correct: false },
      { content: "O(log n)", correct: false }
    ]
  },
  {
    content: "Which data structure uses a FIFO (First In, First Out) approach?",
    choices_attributes: [
      { content: "Stack", correct: false },
      { content: "Queue", correct: true },
      { content: "Heap", correct: false }
    ]
  },
  {
    content: "What is the main advantage of using a hash table?",
    choices_attributes: [
      { content: "Fast lookups by key", correct: true },
      { content: "Low memory usage", correct: false },
      { content: "Simpler implementation compared to arrays", correct: false }
    ]
  },
  {
    content: "Which data structure is best suited for implementing undo functionality?",
    choices_attributes: [
      { content: "Queue", correct: false },
      { content: "Stack", correct: true },
      { content: "Array", correct: false }
    ]
  },
  {
    content: "What is the time complexity of searching for an element in a balanced binary search tree?",
    choices_attributes: [
      { content: "O(1)", correct: false },
      { content: "O(log n)", correct: true },
      { content: "O(n^2)", correct: false }
    ]
  },
  {
    content: "Which data structure is commonly used for graph traversal in breadth-first search?",
    choices_attributes: [
      { content: "Stack", correct: false },
      { content: "Queue", correct: true },
      { content: "Priority Queue", correct: false }
    ]
  },
  {
    content: "In a linked list, what is the time complexity of inserting a new node at the beginning?",
    choices_attributes: [
      { content: "O(n)", correct: false },
      { content: "O(1)", correct: true },
      { content: "O(log n)", correct: false }
    ]
  },
  {
    content: "What is the primary difference between a stack and a queue?",
    choices_attributes: [
      { content: "Stack is LIFO, Queue is FIFO", correct: true },
      { content: "Stack is FIFO, Queue is LIFO", correct: false },
      { content: "Stack uses arrays, Queue uses linked lists", correct: false }
    ]
  },
  {
    content: "Which of the following is a self-balancing binary search tree?",
    choices_attributes: [
      { content: "Binary Heap", correct: false },
      { content: "AVL Tree", correct: true },
      { content: "Hash Table", correct: false }
    ]
  },
  {
    content: "What is the space complexity of a hash table in the worst-case scenario?",
    choices_attributes: [
      { content: "O(1)", correct: false },
      { content: "O(n)", correct: true },
      { content: "O(log n)", correct: false }
    ]
  }
])
quiz_2 = Quiz.create!(
  title: "Fundamentals of Data Structures",
  description: "Assess your understanding of essential data structures and their applications. This quiz is designed for junior developers looking to strengthen their foundational knowledge.",
  author: user_1
)

quiz_2.questions.create!([
  {
    content: "What is the time complexity of accessing an element by index in an array?",
    choices_attributes: [
      { content: "O(1)", correct: true },
      { content: "O(n)", correct: false },
      { content: "O(log n)", correct: false }
    ]
  },
  {
    content: "Which data structure uses a FIFO (First In, First Out) approach?",
    choices_attributes: [
      { content: "Stack", correct: false },
      { content: "Queue", correct: true },
      { content: "Heap", correct: false }
    ]
  },
  {
    content: "What is the main advantage of using a hash table?",
    choices_attributes: [
      { content: "Fast lookups by key", correct: true },
      { content: "Low memory usage", correct: false },
      { content: "Simpler implementation compared to arrays", correct: false }
    ]
  },
  {
    content: "Which data structure is best suited for implementing undo functionality?",
    choices_attributes: [
      { content: "Queue", correct: false },
      { content: "Stack", correct: true },
      { content: "Array", correct: false }
    ]
  },
  {
    content: "What is the time complexity of searching for an element in a balanced binary search tree?",
    choices_attributes: [
      { content: "O(1)", correct: false },
      { content: "O(log n)", correct: true },
      { content: "O(n^2)", correct: false }
    ]
  },
  {
    content: "Which data structure is commonly used for graph traversal in breadth-first search?",
    choices_attributes: [
      { content: "Stack", correct: false },
      { content: "Queue", correct: true },
      { content: "Priority Queue", correct: false }
    ]
  },
  {
    content: "In a linked list, what is the time complexity of inserting a new node at the beginning?",
    choices_attributes: [
      { content: "O(n)", correct: false },
      { content: "O(1)", correct: true },
      { content: "O(log n)", correct: false }
    ]
  },
  {
    content: "What is the primary difference between a stack and a queue?",
    choices_attributes: [
      { content: "Stack is LIFO, Queue is FIFO", correct: true },
      { content: "Stack is FIFO, Queue is LIFO", correct: false },
      { content: "Stack uses arrays, Queue uses linked lists", correct: false }
    ]
  },
  {
    content: "Which of the following is a self-balancing binary search tree?",
    choices_attributes: [
      { content: "Binary Heap", correct: false },
      { content: "AVL Tree", correct: true },
      { content: "Hash Table", correct: false }
    ]
  },
  {
    content: "What is the space complexity of a hash table in the worst-case scenario?",
    choices_attributes: [
      { content: "O(1)", correct: false },
      { content: "O(n)", correct: true },
      { content: "O(log n)", correct: false }
    ]
  }
])

quiz_comics = Quiz.create!(
  title: "Comic Book Knowledge",
  description: "Test your knowledge of comic book history, characters, and publishers! This quiz covers both classic and modern comic book lore.",
  author: user_2
)

quiz_comics.questions.create!([
  {
    content: "Which comic book company introduced Spider-Man?",
    choices_attributes: [
      { content: "Marvel Comics", correct: true },
      { content: "DC Comics", correct: false },
      { content: "Image Comics", correct: false }
    ]
  },
  {
    content: "What is Superman’s home planet?",
    choices_attributes: [
      { content: "Krypton", correct: true },
      { content: "Mars", correct: false },
      { content: "Asgard", correct: false }
    ]
  },
  {
    content: "Who is the archenemy of Batman?",
    choices_attributes: [
      { content: "The Joker", correct: true },
      { content: "Lex Luthor", correct: false },
      { content: "Doctor Doom", correct: false }
    ]
  },
  {
    content: "What is the name of Thor’s enchanted hammer?",
    choices_attributes: [
      { content: "Mjolnir", correct: true },
      { content: "Stormbreaker", correct: false },
      { content: "Excalibur", correct: false }
    ]
  },
  {
    content: "Which superhero team includes characters like Cyclops, Wolverine, and Storm?",
    choices_attributes: [
      { content: "X-Men", correct: true },
      { content: "The Avengers", correct: false },
      { content: "The Justice League", correct: false }
    ]
  }
])

puts "SEEDING DECKS & FLASHCARDS"

deck_1 = user_1.authored_decks.create!(
  title: 'Design Patterns',
  description: 'An introductory set of flashcards to help identify and understand common design patterns in software development.',
)