class CoursePolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    true
  end

  def admin?
    user.present? && user.admin?
  end

  def create?
    admin?
  end

  def new?
    create?
  end

  def update?
    admin?
  end

  def edit?
    update?
  end

  def destroy?
    admin?
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
