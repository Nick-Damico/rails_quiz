module CardHelper
  def new_card?(card)
    !!card.id
  end

  def card_text_tag(text, wrapping_tag: :p)
    classes = %w[ flex whitespace-pre-line text-md pt-2 ]

    content_tag(wrapping_tag.to_sym, class: classes) do
      text
    end
  end
end
