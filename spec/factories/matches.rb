FactoryBot.define do
  factory :match do
    user { create :user }
    pair { create :pair }
  end
end
