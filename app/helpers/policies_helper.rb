module PoliciesHelper
  def can_edit?(obj)
    policy(obj).edit?
  end

  def can_destroy?(obj)
    policy(obj).destroy?
  end
end
