module QuestionHelper
  def num_to_letter(num)
    return if num.negative?

    ("a".."z").to_a[num]
  end
end
