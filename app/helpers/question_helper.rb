module QuestionHelper
  include CollectionHelper

  def num_to_letter(num)
    num = num.to_i
    return if num.negative?

    ("a".."z").to_a[num]
  end

  def question_number(question, ids)
    id_index(question.id, ids) + 1
  end

  def prev_question_id(question, ids)
    ids[id_index(question.id, ids) - 1]
  end

  def next_question_id(question, ids)
    next_id(question.id, ids)
  end

  def formatted_text_tag(text, wrapping_tag: :p)
    classes = %w[ flex whitespace-pre-line text-md pt-2 ]

    content_tag(wrapping_tag.to_sym, class: classes) do
      text
    end
  end
end
