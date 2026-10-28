# MVP Quizzes

- General
  - [x] Display 'No questions' on the Quiz show view.
  - [ ] Feat: Add a rich text content editor. Like Action Text.

- Style Question Form:
  - 1. Larger fields
  - [x] 2. Two 'choices' are required. Default to two empty fields for user convenience.
  - 3. Feat: implement rich text editor

- Route Restrictions:
  - [x] Protect resources that belong to authors and users.
  - [x] Admin Dashboard
  - [x] User Dashboard
  - [ ] Text search with filtering on intial search. This will require some JavaScript to set the hidden field of category_ids on the search component as the user selects.

- Admin:
  - Deactivate a `User` workflow.
  - Deleting `Users` quiz and deck.
    - Admin clicks `deactivate`.
    - Removes `deck` or `quiz` from public (unpublish).
    - Removes the ability for the User to re-publish
    - Later: Add notes from `Admin` on why/reason for disabling.
    - Later: Give users a path back to republishing (define rules/guidelines for public quizzes/decks)
