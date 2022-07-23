# frozen_string_literal: true

class BulletinPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    true
  end

  def create?
    user_exists?
  end

  def update?
    user_owns_record?
  end

  def destroy?
    user_owns_record?
  end
end
