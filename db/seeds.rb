# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Faker::UniqueGenerator.clear

# create our first Candidate and our first candidate
UserCandidate.create(email: "linkdrcan@linkdr.com", password: "password")
firstCandidate = Candidate.first
# Fill in our first candidate info
UserCompany.create(email: "linkdrcom@linkdr.com", password: "password")
firstCompany = Company.first
# Fill in our first company info

# Have one skill
Skill.create(name: Faker::ProgrammingLanguage.unique.name)

1.time do
  Skill.create(name: Faker::ProgrammingLanguage.unique.name)
end
