require 'rails_helper'

RSpec.describe Match, type: :model do
  describe "association with user" do
    let(:user) { create :user }
    let!(:match) { create :match, user_id: user.id}

    it "belongs to a user" do
      expect(match.user).to eq(user)
    end
  end

  describe "association with pair" do
    let(:pair) { create :pair }
    let!(:match) { create :match, pair_id: pair.id}

    it "belongs to a pair" do
      expect(match.pair).to eq(pair)
    end
  end
end
