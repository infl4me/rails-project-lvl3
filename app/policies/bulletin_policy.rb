# frozen_string_literal: true

class BulletinPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    true
  end

  def create?
    user_exists? || user_admin?
  end

  def update?
    user_owns_record? || user_admin?
  end

  def destroy?
    user_owns_record? || user_admin?
  end

  def to_moderate?
    user_owns_record? || user_admin?
  end

  def publish?
    user_admin?
  end

  def reject?
    user_admin?
  end

  def archive?
    user_owns_record? || user_admin?
  end
end
