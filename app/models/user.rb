# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  email           :string           not null
#  password_digest :string           not null
#  admin           :boolean          default(FALSE), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ApplicationRecord

  has_secure_password

  has_many :grants
  has_many :reviews

  def author?
    !admin?
  end

  def can_update_grant?(grant)
    return true if admin?
    grant.review.blank? || grant.review.rejected?
  end

  def can_sync_grant?(grant)
    return false unless admin?
    grant.persisted? && grant.review.present? && grant.review.approved?
  end

  def can_submit_review?(review)
    return false unless author?
    !review.persisted? || review.rejected?
  end

  def can_approve_review?(review)
    return false unless admin?
    review.present? && review.pending?
  end

end
