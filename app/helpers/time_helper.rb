
module TimeHelper
  def seconds_to_minutes(seconds)
    to_duration(seconds).parts[:minutes] || 1
  end

  def to_duration(seconds)
    ActiveSupport::Duration.build(seconds)
  end

  def format_time(seconds)
    mins, secs = seconds.divmod(ActiveSupport::Duration::SECONDS_PER_MINUTE)

    parts = []
    parts << "#{mins}mins" if mins.positive?
    parts << "#{secs}secs" if secs.positive?
    parts.join(" ")
  end
end
