require 'rails_helper'

RSpec.describe Pair, type: :model do
  describe "validations" do
    it "is invalid without a date" do
      pair = Pair.new(date: nil)
      pair.valid?
      expect(pair.errors).to have_key(:date)
    end
  end

  describe "association with matches" do
    it "has many matches"
    it "deletes associated matches"
  end
end
