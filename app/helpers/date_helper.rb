module DateHelper
  def strftime(time, format = "%b %d %Y")
    time.strftime(format)
  end
end
