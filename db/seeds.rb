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

user1 = User.create!(email: "admin@test.com", password: "123456", first_name: "Henk", last_name: "de Hond", admin: true)

user2 = User.create!(email: "stu1@test.com", password: "123456", first_name: "Jason", last_name: "Statham")
user3 = User.create!(email: "stu2@test.com", password: "123456", first_name: "Queen", last_name: "Elisabeth")
user4 = User.create!(email: "stu3@test.com", password: "123456", first_name: "Bono", last_name: "I_Need_A_Last_Name")
user5 = User.create!(email: "stu4@test.com", password: "123456", first_name: "Jackie", last_name: "Chan")

user6 = FactoryBot.create :user, email: "stu5@test.com", password: "123456"
user7 = FactoryBot.create :user, email: "stu6@test.com", password: "123456"

pair1 = FactoryBot.create :pair
pair2 = FactoryBot.create :pair
pair3 = FactoryBot.create :pair

match1 = Match.create!(pair: pair1, user: user2)
match2 = Match.create!(pair: pair1, user: user3)
match3 = Match.create!(pair: pair2, user: user4)
match4 = Match.create!(pair: pair2, user: user5)
match5 = Match.create!(pair: pair3, user: user5)
match6 = Match.create!(pair: pair3, user: user6)
match7 = Match.create!(pair: pair3, user: user7)
