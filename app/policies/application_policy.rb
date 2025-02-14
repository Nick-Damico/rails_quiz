# frozen_string_literal: true

class ApplicationPolicy
  class Scope
    private attr_reader :user, :scope

    def initialize(user, scope)
      raise Pundit::NotAuthorizedError unless user

      @user = user
      @scope = scope
    end

    def resolve
      raise NoMethodError, "You must define #resolve in #{self.class}"
    end
  end

  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    false
  end

  def show?
    false
  end

  def create?
    false
  end

  def new?
    create?
  end

  def update?
    false
  end

  def edit?
    update?
  end

  def destroy?
    false
  end

  def user_is_owner?
    user.id == (record.try(:user_id) || record.try(:author_id))
  end
end
