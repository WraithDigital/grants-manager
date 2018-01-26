# == Schema Information
#
# Table name: grants
#
#  id         :integer          not null, primary key
#  agency_id  :integer          not null
#  user_id    :integer          not null
#  title      :string
#  url        :string           not null
#  body       :text
#  dirty      :boolean          default(TRUE), not null
#  remote_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Grant < ApplicationRecord

  has_and_belongs_to_many :applicant_types
  accepts_nested_attributes_for :applicant_types

  belongs_to :agency
  belongs_to :user
  has_many   :deadlines
  has_one    :review

  validates :url, presence: true, url: {no_local: true}

  def self.per_page
    20
  end

end
