# QuizIT

QuizIT is a Ruby on Rails application designed to help users create, organize, and study using quizzes and flashcards. Inspired by tools like Anki, QuizIT aims to provide a streamlined experience for both personal learning and collaborative sharing.

---

## Features

### Current Features

- **Quiz and Flashcard Creation**: Users can create custom quizzes and flashcards for studying.
- **User Management**: Secure user accounts to organize and manage your study materials.

### Upcoming Features

- **Sharing**: Share your quizzes and flashcards with other users.
- **Rating System**: Rate and discover highly-rated quizzes created by other users (authors).

---

## Installation

1. Clone the repository:

   ```bash
   git clone https://github.com/your-username/quizit.git
   cd quizit
   ```

2. Install dependencies:

   ```bash
   bundle install
   ```

3. Set up the database:

   ```bash
   rails db:setup
   ```

4. Start the Rails server:

   ```bash
   rails server
   ```

5. Visit the application in your browser at `http://localhost:5000`.

---

## Usage

1. Sign up or log in to your account.
2. Create quizzes and flashcards tailored to your learning needs.
3. Save, organize, and manage your study materials.

---

## Contributing

Contributions are welcome! To contribute:

1. Fork the repository.
2. Create a feature branch:
   ```bash
   git checkout -b feature-name
   ```
3. Commit your changes and push to your fork:
   ```bash
   git commit -m "Add feature-name"
   git push origin feature-name
   ```
4. Open a pull request to the main repository.

---

## Troubleshooting

`The asset "tailwind.css" is not present in the asset pipeline.`

- Tailwindcss output file might have been deleted via `bin/rails assets:clobber`.
- **To Fix:** `bin/rails tailwindcss:build`

---

## License

This project is licensed under the [MIT License](LICENSE).

---

## Contact

For questions or feedback, please reach out to:

- **Project Maintainer**: [Your Name](mailto:your-email@example.com)
- **GitHub Repository**: [QuizIT](https://github.com/your-username/quizit)
