class Dashboard::UserPolicy < ApplicationPolicy
  def show?
    is_current_user?
  end

  def update?
    is_current_user?
  end

  private

    def is_current_user?
      user == record
    end
end
