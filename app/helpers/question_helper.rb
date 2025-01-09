module QuestionHelper
  def num_to_letter(num)
    num = num.to_i
    return if num.negative?

    ("a".."z").to_a[num]
  end

  def question_index(question, ids)
    ids.index(question.id)
  end

  def question_number(question, ids)
    ids.index(question.id) + 1
  end

  def prev_question_id(question, ids)
    ids[question_index(question, ids) - 1]
  end

  def next_question_id(question, ids)
    next_possible_id = question_index(question, ids) + 1

    ids[next_possible_id % ids.length]
  end
end
