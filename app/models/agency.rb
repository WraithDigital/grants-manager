# == Schema Information
#
# Table name: agencies
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  shortname  :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Agency < ApplicationRecord

  has_many :grants

  validates :name, presence: true

end
