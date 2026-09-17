class Admin::DeckPolicy < AdminPolicy
  class Scope < ApplicationPolicy::Scope
    def resolve
      @scope.all
    end
  end
end
