class UserDeck < ApplicationRecord
  belongs_to :user
  belongs_to :deck

  has_many :user_deck_cards, dependent: :destroy
  has_many :cards, through: :user_deck_cards

  delegate :cards, to: :deck, allow_nil: true

  # TODO: Move to callback
  def build_user_cards
    return unless cards.present?

    user_deck_cards.build(new_cards.map { |card| { card: } })
  end

  def completed?
    !!completed_at
  end

  def completed_in_seconds
    (completed_at - started_at).round
  end

  def find_card_with_fallback(card_id, fallback_method: :first)
    allowed_fallbacks = %i[first last]
    fallback_method = :first unless allowed_fallbacks.include?(fallback_method)

    user_deck_cards.find_by(id: card_id) || user_deck_cards.sort_by(&:id).send(fallback_method)
  end

  def mark_started
    set_current_time_for(:started_at)
  end

  def mark_completed
    set_current_time_for(:completed_at)
  end

  private

    def set_current_time_for(column)
      update_column(column, Time.current.utc)
    end

    def new_cards
      Decks::Card.new_cards(self)
    end
end
