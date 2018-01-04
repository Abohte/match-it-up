class Pair < ApplicationRecord
  has_many :matches, dependent: :destroy
  has_many :students, through: :matches, source: :user

  validates :date, presence: true

  def future?
    self.date > Date.today
  end

  def pretty_print
    self.students.map{|student| student.full_name}.join(" , ")
  end

end
