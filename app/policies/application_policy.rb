# frozen_string_literal: true

class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    raise Pundit::NotAuthorizedError, 'You need to sign in or sign up before continuing.' unless user

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

  private

  def is_admin?
    @user.has_role?(:admin)
  end

  def is_author?
    @user.author?(record)
  end

  class Scope
    def initialize(user, scope)
      raise Pundit::NotAuthorizedError, 'You need to sign in or sign up before continuing.' unless user

      @user = user
      @scope = scope
    end

    def resolve
      raise NotImplementedError, "You must define #resolve in #{self.class}"
    end

    private

    attr_reader :user, :scope
  end
end
