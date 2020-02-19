# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Faker::UniqueGenerator.clear

# UserCandidate.create(email: "linkdr@linkdr.com", password: "password")
# Fill in our first candidate info
# UserCompany.create(email: "linkdr@linkdr.com", password: "password")
# Fill in our first company info

20.times do
  Skill.create(name: Faker::ProgrammingLanguage.unique.name)
end
