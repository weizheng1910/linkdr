# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Faker::UniqueGenerator.clear

skills = ["Javascript", "HTML", "CSS", "Node.js",
  "Express.js", "Ruby on Rails", "React", "PostgreSQL",
  "Python", "Git", "Java", "PHP" ]

# Create skills
skills.each do |skill|
  Skill.create(name: skill)
end

# create our first Candidate who has one skill
UserCandidate.create(email: "linkdrcan@linkdr.com", password: "password")
# Automatically generates a blank first candidate profile. Fill it in.
firstCandidate = Candidate.first
firstCandidate.given_name = Faker::Name.first_name
firstCandidate.family_name = Faker::Name.last_name
firstCandidate.years_of_experience = Faker::Number.number(digits: 1)
firstCandidate.expected_salary = Faker::Number.number(digits: 4).to_s
firstCandidate.bio = Faker::TvShows::TheFreshPrinceOfBelAir.quote
firstCandidate.skills << Skill.first
firstCandidate.save
# Fill in our first company info
UserCompany.create(email: "linkdrcom@linkdr.com", password: "password")
firstCompany = Company.first
firstCompany.name = Faker::Company.name
firstCompany.industry = Faker::Company.industry
firstCompany.size = Faker::Company.bs
firstCompany.user_company_id = 1
firstCompany.save

# Create our first job!
Job.create(
  title: Faker::Job.title,
  description: Faker::Lorem.paragraph,
  offered_salary: "$" + Faker::Number.number(digits: 4).to_s + " pcm",
  country: "Singapore",
  company_id: 1
)

firstJob = Job.first
firstJob.skills << Skill.first
firstJob.save

# Create our second job!
secondJob = Job.create(
  title: "Software Dev 1",
  description: Faker::Lorem.paragraph,
  offered_salary: "$6000 pcm",
  country: "Singapore",
  company_id: 1,
)

secondJob.skills << Skill.first
secondJob.save

thirdJob = Job.create(
  title: "Software Dev 2",
  description: Faker::Lorem.paragraph,
  offered_salary: "$7000 pcm",
  country: "Singapore",
  company_id: 1,
)

thirdJob.skills << Skill.first
thirdJob.save

10.times do
  newJob = Job.new(
    title: Faker::Job.title,
    description: Faker::Lorem.paragraph,
    offered_salary: "$" + Faker::Number.number(digits: 4).to_s + " pcm",
    country: "Singapore",
    company_id: 1
  )
  5.times do
    skill = Skill.order('RANDOM()').first
    if newJob.skills.include? skill
      next
    else
      newJob.skills << skill
    end
  end
  newJob.save
end

# 50 new candidates with random profiles n stuff
50.times do
  UserCandidate.create(
    email: Faker::Internet.unique.safe_email,
    password: Faker::Internet.password
  )
  candidate = Candidate.last
  candidate.given_name = Faker::Name.first_name
  candidate.family_name = Faker::Name.last_name
  candidate.years_of_experience = Faker::Number.number(digits: 1)
  candidate.expected_salary = Faker::Number.number(digits: 4).to_s
  candidate.bio = Faker::TvShows::TheFreshPrinceOfBelAir.quote
  10.times do
    skill = Skill.order('RANDOM()').first
    if candidate.skills.include? skill
      next
    else
      candidate.skills << skill
    end
  end
  candidate.save
end
