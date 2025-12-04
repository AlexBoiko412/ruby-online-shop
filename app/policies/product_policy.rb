class ProductPolicy < ApplicationPolicy
  def index?    = user.admin?
  def show?     = true
  def create?   = user.admin?
  def new?      = user.admin?
  def update?   = user.admin?
  def edit?     = user.admin?
  def destroy?  = user.admin?

  class Scope < Scope
    def resolve
      user.admin? ? scope.all : scope.none
    end
  end
end