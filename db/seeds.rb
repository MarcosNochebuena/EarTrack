# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

setting = Setting.find_or_create_by(
  produced_adress: Faker::Address.full_address, 
  producer_full_name: Faker::Name.name, 
  upp_key: 130361290001)

5.times do
  Key.find_or_create_by(
    num_key: Faker::Number.number(digits: 6), 
    upp: setting.upp_key)
end

100.times.with_index do |i|
  keys = Key.all
  Earring.create(
    age: Faker::Number.within(range: 1..60),
    earring: Faker::Number.number(digits: 4), 
    gender: Faker::Gender.binary_type.downcase, 
    status: :live, 
    key_id: keys.sample.id)
end