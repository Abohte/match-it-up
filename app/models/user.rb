class User < ApplicationRecord
  after_initialize :set_default_admin_value
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :matches, dependent: :destroy
  has_many :pairs, through: :matches

  validates :first_name, presence: true
  validates :last_name, presence: true

  def full_name
    "#{first_name} #{last_name}"
  end

  def valid_pairs
    _valid_pairs
  end

  def self.all_names
    self.all.map{|user| user.full_name}
  end

  private


  def _valid_pairs
    if self.admin
      return Pair.all
    else
      return _non_future_pairs
    end
  end

  def _non_future_pairs
    if self.pairs.any?
      return self.pairs.select{|pair| !pair.future?}
    end
  end

  def set_default_admin_value
    self.admin ||= false
  end
end
