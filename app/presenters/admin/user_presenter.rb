class Admin::UserPresenter
  attr_reader :user

  def initialize(user)
    @user = user
  end

  def to_model
    user
  end

  def id
    user.id
  end

  def field_names
    %i[username email created_on actions]
  end

  def username
    user.username
  end

  def created_on
    user.created_at.strftime("%Y-%m-%d")
  end

  def email
    user.email
  end
end
