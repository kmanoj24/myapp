# app/policies/customer_policy.rb
class CustomerPolicy < ApplicationPolicy
  def index?
    user.admin?
  end

  def show?
    user.admin?
  end
end
