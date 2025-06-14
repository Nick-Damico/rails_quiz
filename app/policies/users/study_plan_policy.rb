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

  # def show?
  #   UserDeckPolicy.new(user, record.user_deck).user_is_owner?
  # end

  # def update?
  #   UserDeckPolicy.new(user, record.user_deck).user_is_owner?
  # end
end
