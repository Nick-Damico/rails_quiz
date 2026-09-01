class Admin::QuizPolicy < ApplicationPolicy
  class Scope < ApplicationPolicy::Scope
    def resolve
      if @user.admin?
        @scope.all
      end
    end
  end
end
