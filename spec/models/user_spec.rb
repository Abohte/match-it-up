require 'rails_helper'

RSpec.describe User, type: :model do
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

    it "is by default not an admin"
  end

  describe ".full_name" do
    it "returns first name and last name combined" do
      user = User.new(first_name: "Tom", last_name: "Bear")
      expect(user.full_name).to eq("Tom Bear")
    end
  end

  describe "association with matches" do
    it "has many matches"
    it "deletes associated matches"
  end
end
