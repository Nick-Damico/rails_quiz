
module TimeHelper
  def seconds_to_minutes(seconds)
    ActiveSupport::Duration.build(seconds).parts[:minutes] || 1
  end
end
