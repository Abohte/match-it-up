class Pair < ApplicationRecord
  has_many :matches, dependent: :destroy
  has_many :students, through: :matches, source: :user

  validates :date, presence: true
end
