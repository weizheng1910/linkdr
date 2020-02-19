# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Faker::UniqueGenerator.clear

# Have one skill
Skill.create(name: Faker::ProgrammingLanguage.unique.name)

# create our first Candidate who has our one skill
UserCandidate.create(email: "linkdrcan@linkdr.com", password: "password")
# Automatically generates a blank first candidate profile. Fill it in.
firstCandidate = Candidate.first
firstCandidate.given_name = Faker::Name.first_name,
firstCandidate.family_name = Faker::Name.last_name,
firstCandidate.skills << Skill.first
firstCandidate.save

# Create our first company
UserCompany.create(email: "linkdrcom@linkdr.com", password: "password")
# Automatically generates a blank first company profile. Fill it in.
# Fill in our first company info
firstCompany = Company.first
firstCompany.name = Faker::Company.name
firstCompany.industry = Faker::Company.industry
firstCompany.size = Faker::Company.bs
# Create our first job!
Job.create(
  title: Faker::Job.title,
  description: Faker::Lorem.paragraph,
  offered_salary: "$5000 pcm",
  country: "Singapore",
  company_id: 1)
firstJob = Job.first
firstJob.skills << Skill.first
firstJob.save

1.time do
  Skill.create(name: Faker::ProgrammingLanguage.unique.name)
end
