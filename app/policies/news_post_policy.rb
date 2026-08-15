class NewsPostPolicy < ApplicationPolicy
  def scope(user, scope); end

  def show?
    true
  end
end
