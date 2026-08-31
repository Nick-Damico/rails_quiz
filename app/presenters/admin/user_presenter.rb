class UserPresenter
  attr_reader :user

  def initialize(user)
    @user = user 
  end

  def columns
    %i[username email created_on actions]
  end
end
