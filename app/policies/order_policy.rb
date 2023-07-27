class OrderPolicy < ApplicationPolicy
  def admin?
    user.present? && user.admin?
  end

  def create?
    user.admin?
  end

  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.all
    end
  end
end
