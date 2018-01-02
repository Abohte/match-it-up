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
    let(:pair) { create :pair }
    let!(:match) { create :match, pair_id: pair.id}

    it "has many matches" do
      match1 = pair.matches.new
      match2 = pair.matches.new
      expect(pair.matches).to include(match1)
      expect(pair.matches).to include(match2)
    end

    it "deletes associated matches" do
      expect { pair.destroy }.to change(Match, :count).by(-1)
    end
  end
end
