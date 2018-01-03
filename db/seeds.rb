# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'factory_bot_rails'

Pair.destroy_all
Match.destroy_all
User.destroy_all

user1 = User.create!(email: "test@test.com", password: "123456", first_name: "Henk", last_name: "de Hond", admin: true)

user2 = FactoryBot.create :user
user3 = FactoryBot.create :user
user4 = FactoryBot.create :user
user5 = FactoryBot.create :user
user6 = FactoryBot.create :user
user7 = FactoryBot.create :user


pair = FactoryBot.create :pair

match2 = Match.create!(pair: pair, user: user2)
match1 = Match.create!(pair: pair, user: user3)
