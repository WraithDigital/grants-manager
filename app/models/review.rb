# == Schema Information
#
# Table name: reviews
#
#  id              :integer          not null, primary key
#  grant_id        :integer          not null
#  user_id         :integer          not null
#  status          :string           not null
#  submitter_notes :text
#  reviewer_notes  :text
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Review < ApplicationRecord

  REVIEW_TYPES = %w(pending approved rejected)

  belongs_to :grant
  belongs_to :user

  validates :status, presence: true, inclusion: { in: REVIEW_TYPES }

  def pending?
    status == 'pending'
  end

  def approved?
    status == 'approved'
  end

  def rejected?
    status == 'rejected'
  end

end
