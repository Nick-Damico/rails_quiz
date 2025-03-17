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
end
