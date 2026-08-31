class Admin::UserPresenter
  attr_reader :user

  def initialize(user)
    @user = user
  end

  def to_model
    user
  end

  def field_names
    %i[username email created_on actions]
  end

  def title
    user.username
  end

  def created_on
    user.created_at.strftime("%Y-%m-%d")
  end

  def description
    user.email
  end
end
