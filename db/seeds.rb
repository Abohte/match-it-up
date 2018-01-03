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

user2 = User.create!(email: "stu1@test.com", password: "123456", first_name: "Jason", last_name: "Statham", admin: false)
user3 = User.create!(email: "stu2@test.com", password: "123456", first_name: "Queen", last_name: "Elisabeth", admin: false)
user4 = User.create!(email: "stu3@test.com", password: "123456", first_name: "Bono", last_name: "I_Need_A_Last_Name", admin: false)
user5 = User.create!(email: "stu4@test.com", password: "123456", first_name: "Jackie", last_name: "Chan", admin: false)

# user2 = FactoryBot.create :user
# user3 = FactoryBot.create :user

pair1 = FactoryBot.create :pair
pair2 = FactoryBot.create :pair

match1 = Match.create!(pair: pair1, user: user2)
match2 = Match.create!(pair: pair1, user: user3)
match2 = Match.create!(pair: pair2, user: user4)
match2 = Match.create!(pair: pair2, user: user5)
