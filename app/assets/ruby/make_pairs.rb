ERROR_MESSAGE = "Pairs are already made for this day. To make new pairs, first delete the pairs for the day in question."

def generate(date = Date.today)
  return ERROR_MESSAGE if Pair.exists?(date: date)

  totalpairs = []

  if PairingProgress.any?
    @group = PairingProgress.last.current_students_order
    @count  = PairingProgress.last.current_iteration
  else
    @group = set_group if @group.nil?
    @count = 0 if @count.nil?
  end

  if group_changed?(@group) || all_pairs_made?(@group, @count)
    @count = 0
    @group = set_group
  end
  current_group_order = @group.dup
  @count += 1
  while current_group_order.length != 0 do
    if (current_group_order.length % 2 != 0)
      odd_user = current_group_order.shift
    end
    user1 = current_group_order.shift
    user2 = current_group_order.pop

    pair = Pair.new(date: date)

    if pair.save!
      totalpairs << pair
    end
    Match.create!(user_id: user1, pair: pair)
    Match.create!(user_id: user2, pair: pair)
  end
  if !odd_user.nil?
    Match.create!(user_id: odd_user, pair: pair)
  end
  @group = create_next_group_order(@group)

  PairingProgress.destroy_all if PairingProgress.any?
  PairingProgress.create!(current_students_order: @group, current_iteration: @count)

  return totalpairs
end

def set_group
  User.where(admin: false).ids.shuffle
end

def create_next_group_order(current_group_order)
  [current_group_order[0]] + current_group_order[1..-1].rotate(-1)
end

def all_pairs_made?(current_group, count)
  if current_group.length % 2 == 0
    current_group.length-1 == count
  else
    current_group.length-2 == count
  end
end

def group_changed?(current_group)
  new_group = set_group
  new_group.sort != current_group.sort
end
