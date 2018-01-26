class Deadline < ApplicationRecord

  belongs_to :grant

  validates :item_due, presence: true
  validates :notes,    presence: true
end
