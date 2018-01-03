class Pair < ApplicationRecord
  has_many :matches, dependent: :destroy
  has_many :students, through: :matches, source: :user

  validates :date, presence: true

  def future?
    self.date > Date.today
  end




end
