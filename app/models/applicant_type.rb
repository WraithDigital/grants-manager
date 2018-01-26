class ApplicantType < ApplicationRecord

  has_and_belongs_to_many :grants

  validates :name, presence: true

end
