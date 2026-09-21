class Admin::UserPresenter
  attr_reader :user

  delegate :id, :username, :hidden?, :email, :to_model, to: :user

  def initialize(user)
    @user = user
  end

  def to_param
    String(user.id)
  end

  def field_names
    %i[username email created_on actions]
  end

  def created_on
    user.created_at.strftime("%Y-%m-%d")
  end
end
