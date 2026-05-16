module UserHelper
  def display_rank(user)
    return "No Rank" unless user.rank

    user.rank.titleize
  end
end
