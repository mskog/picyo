class AlbumPolicy < ApplicationPolicy

  def show?
    @user.present? && @record.user == @user
  end

  def destroy?
    @user.present? && @record.user == @user
  end

  def update?
    @user.present? && @record.user == @user
  end

  class Scope < Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope.where(user: @user)
    end

  end
end
