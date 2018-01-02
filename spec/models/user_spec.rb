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
