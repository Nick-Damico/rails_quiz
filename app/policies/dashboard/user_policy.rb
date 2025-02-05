class Dashboard::UserPolicy < ApplicationPolicy
  def show?
    update?
  end

  def update?
    user == record
  end
end
