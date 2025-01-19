module NumberHelper
  def format_as_two_digits(number)
    sprintf("%02d" % number)
  end
end
