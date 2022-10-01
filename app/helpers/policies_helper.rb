module PoliciesHelper
  def can_edit?(obj)
    policy(obj).edit?
  end

  def can_destroy?(obj)
    policy(obj).destroy?
  end

  def can_build?(obj)
    policy(obj).new?
  end
end
