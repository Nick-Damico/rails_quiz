module QuestionHelper
  def num_to_letter(num)
    num = num.to_i
    return if num.negative?

    ("a".."z").to_a[num]
  end
end
