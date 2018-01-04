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


# Algorithm

public

  # def self.generate_pairs
  #   @group = User.set_group if @group.nil?
  #   @count = 0 if @count.nil?
  #   if User.group_changed?(@group) || User.all_pairs_made?(@group, @count)
  #     @count = 0
  #     @group = User.set_group
  #   end
  #   current_group_order = @group.dup
  #   @count += 1
  #   while current_group_order.length != 0 do
  #     if (current_group_order.length % 2 != 0)
  #       odd_user = current_group_order.shift
  #     end
  #     user1 = current_group_order.shift
  #     user2 = current_group_order.pop
  #     pair = Pair.create!(date: Date.today)
  #     Match.create!(user_id: user1, pair: pair)
  #     Match.create!(user_id: user2, pair: pair)
  #   end
  #   if !odd_user.nil?
  #     Match.create!(user_id: odd_user, pair: pair)
  #   end
  #   @group = User.create_next_group_order(@group)
  # end
  #
  # def self.set_group
  #   User.where(admin: false).ids.shuffle
  # end
  #
  # def self.create_next_group_order(current_group_order)
  #   [current_group_order[0]] + current_group_order[1..-1].rotate(-1)
  # end
  #
  # def self.all_pairs_made?(current_group, count)
  #   current_group.length-1 == count
  # end
  #
  # def self.group_changed?(current_group)
  #   new_group = User.set_group
  #   new_group.sort != current_group.sort
  # end
end
