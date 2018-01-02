require 'date'

FactoryBot.define do
  factory :pair do
    date { Date.today }
  end
end
