class Dashboard::UserPolicy < ApplicationPolicy
  def show?
    is_current_user?
  end

  def update?
    is_current_user?
  end

  def public_profile?
    true
  end

  private

    def is_current_user?
      user == record
    end
end
