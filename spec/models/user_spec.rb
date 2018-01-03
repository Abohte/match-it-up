require 'rails_helper'

RSpec.describe User, type: :model do
  describe "create user" do
    it "is by default not an admin" do
      user = User.new
      expect(user.admin).to eq(false)
    end
  end

  describe "validations" do
    it "is invalid without a first name" do
      user = User.new(first_name: nil)
      user.valid?
      expect(user.errors).to have_key(:first_name)
    end

    it "is invalid without a last name" do
      user = User.new(last_name: nil)
      user.valid?
      expect(user.errors).to have_key(:last_name)
    end

    it "is invalid without an email" do
      user = User.new(email: nil)
      user.valid?
      expect(user.errors).to have_key(:email)
    end

    it "is invalid without a password" do
      user = User.new(password: nil)
      user.valid?
      expect(user.errors).to have_key(:password)
    end
  end

  describe ".full_name" do
    it "returns first name and last name combined" do
      user = User.new(first_name: "Tom", last_name: "Bear")
      expect(user.full_name).to eq("Tom Bear")
    end
  end

  describe "association with matches" do
    let(:user) { create :user }
    let!(:match) { create :match, user_id: user.id}

    it "has many matches" do
      match1 = user.matches.new
      match2 = user.matches.new
      expect(user.matches).to include(match1)
      expect(user.matches).to include(match2)
    end

    it "deletes associated matches" do
      expect { user.destroy }.to change(Match, :count).by(-1)
    end
  end
end

describe "pairing algorithm" do
  let!(:user1) { create :user }
  let!(:user2) { create :user }
  let!(:user3) { create :user }
  let!(:user4) { create :user }
  let!(:user5) { create :user, admin: true }

  describe "self.set_group" do
    it "returns an array with all student_ids, no admin_ids" do
      group = User.set_group.sort
      expect(group).to eq([user1.id, user2.id, user3.id, user4.id])
    end
  end

  describe "self.create_next_group_order" do
    it "returns an array with all but the first value rotated" do
      start_group = [1, 2, 3, 4]
      next_group = User.create_next_group_order(start_group)
      expect(next_group).to eq([1, 4, 2, 3])
    end
  end

  describe "self.generate_pairs" do
    context "four students, one admin" do
      it "returns four matches" do
        start_group = User.set_group
        User.generate_pairs(start_group)
        expect(Match.count).to eq(4)
      end
      it "returns two pairs" do
        start_group = User.set_group
        User.generate_pairs(start_group)
        expect(Pair.count).to eq(2)
      end
    end

    context "five students, one admin" do
      let!(:user6) { create :user }
      it "returns four matches" do
        start_group = User.set_group
        User.generate_pairs(start_group)
        expect(Match.count).to eq(5)
      end
      it "returns two pairs" do
        start_group = User.set_group
        User.generate_pairs(start_group)
        expect(Pair.count).to eq(2)
      end
    end
  end

end
