class Users::StudyPlanPolicy < ApplicationPolicy
  class Scope
    def initialize(user, scope)
      @user, @scope = user, scope
    end

    # NOTE: Be explicit about which records you allow access to!
    def resolve
      @scope.all
    end
  end

  def new?
    user_is_owner?
  end

  def create?
    user_is_owner?
  end

  def show?
    user_is_owner?
  end

  def edit?
    user_is_owner?
  end

  def update?
    user_is_owner?
  end

  def destroy?
    user_is_owner?
  end
end
