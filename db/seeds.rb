# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Company
Company.create!(name: "Acme Corporation",
                address1: Faker::Address.street_address,
                address2: Faker::Address.secondary_address,
                city: Faker::Address.city,
                post_code: Faker::Address.postcode,
                country: Faker::Address.country,
                email: Faker::Internet.safe_email("Acme Corporation"),
                contact_number: Faker::PhoneNumber.phone_number)

10.times do
  Company.create!(name: Faker::Company.name,
                  address1: Faker::Address.street_address,
                  address2: Faker::Address.secondary_address,
                  city: Faker::Address.city,
                  post_code: Faker::Address.postcode,
                  country: Faker::Address.country,
                  email: Faker::Internet.safe_email,
                  contact_number: Faker::PhoneNumber.phone_number)
end

# Projects
99.times do |n|
  Project.create!(code: sprintf("PE0%02i", n+1),
                  company: Company.find_by_name("Acme Corporation"),
                  description: Faker::Lorem.sentence(5))
end

# Users
User.create!(name:  "Example User",
             email: "example@railstutorial.org",
             password:              "foobar",
             password_confirmation: "foobar",
             company: Company.find_by_name("Acme Corporation"),
             admin:     true,
             activated: true,
             activated_at: Time.zone.now)

99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:  name,
              email: email,
              password:              password,
              password_confirmation: password,
              company: Company.find_by_name("Acme Corporation"),
              activated: true,
              activated_at: Time.zone.now)
end

# Microposts
users = User.order(:created_at).take(6)
50.times do
  content = Faker::Lorem.sentence(5)
  users.each { |user| user.microposts.create!(content: content) }
end

# Following relationships
users = User.all
user  = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }