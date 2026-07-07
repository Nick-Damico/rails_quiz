# Flash Card Design

# User Stories: Flashcard Deck Feature

## Actor: User

### Creating and Managing a Deck

- As a user, I want to create a deck so that I can organize my flashcards.
- As a user, I want to add a card to the deck so that I can expand my study materials.
- As a user, I want to define the front and back of the card so that I can structure my learning content effectively.

### Reviewing and Scoring Cards

- As a user, I want to review my deck by going through each card one-by-one so that I can study in an organized manner.
- As a user, I want to assign a 'score' to a card based on how confident I am with its contents so that I can track my learning progress.
- As a user, I want cards I feel comfortable with to appear less often than cards with a lower confidence score so that I can focus more on areas that need improvement.

## What are the objects?

- Deck
  - Title
  - Description
  - author_id
- Card
  - front_content
  - back_content
  - deck_id (belong_to)
- I(User/Author)
