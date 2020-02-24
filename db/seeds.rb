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
  "Python", "Git", "Java", "PHP", "Reddit", "Facebooking", "memes", "Pokémon" ]

size_string = ["Small, 0-10 employees", "Medium, 10-50 employees",
  "Large 50-200 employees", "Multinational 200+ employees"]

# Create skills
skills.each do |skill|
  Skill.create(name: skill)
end

# create our first Candidate who has one skill and we can log in and change
UserCandidate.create(email: "linkdrcan@linkdr.com", password: "password")
# Automatically generates a blank first candidate profile. Fill it in.
first_candidate = Candidate.first
first_candidate.given_name = Faker::Name.first_name
first_candidate.family_name = Faker::Name.last_name
first_candidate.years_of_experience = Faker::Number.number(digits: 1)
first_candidate.expected_salary = Faker::Number.number(digits: 4).to_s
first_candidate.bio = Faker::TvShows::TheFreshPrinceOfBelAir.quote
first_candidate.skills << Skill.first
first_candidate.save
# Fill in our first company info
UserCompany.create(email: "linkdrcom@linkdr.com", password: "password")
first_company = Company.first
first_company.name = "Linkdr LLC"
first_company.industry = "Recruitment"
first_company.size = size_string[0]
first_company.user_company_id = 1
first_company.save

# Create our first job!
first_job = Job.new(
  title: "Community Coordinator",
  description: "The Community Coordinator provides community development, advocates for community members, assists clients directly with information and referral services, and facilitates an awareness of social needs and trends within the community.This position maintainscontact withtheLeduc County FCSS Department through the Community SupportCoordinatorand evaluatesprograms offered to ensure compliance with FCSS outcomesmeasurement. We will require successful candidates to be able to post spicy memes on our social media outlets and generate interest in Linkdr and our company partners online, as well as at trade shows and conventions.",
  offered_salary: Faker::Number.number(digits: 4),
  country: "Singapore",
  company_id: 1
)
first_job.skills << Skill.first
first_job.skills << Skill.find_by(name: skills[12])
first_job.skills << Skill.find_by(name: skills[13])
first_job.skills << Skill.find_by(name: skills[14])
first_job.save

# Create our second job!
second_job = Job.new(
  title: "Front End Developer",
  description: "We are seeking a talented Front End Developer to work with its established team of cross-functional UX and Technical professionals. This person will be responsible for the design, development, and functionality of several internal applications.
    Our ideal candidate will:
    Create responsive landing pages using HTML/CSS.
    Proactively collaborate with copywriters, developers, and/or video producers to define the message and specs for the graphic design and web development elements in a project.
    Develop front-end code variations for A/B testing using HTML, CSS.
    Perform quality assurance tests and ascertain the cause of a problem when a test is not performing as expected or adversely affecting other reporting.
    Develop e-commerce sales funnels, promotional efforts, and emails for their millions of readers.
    Design multiple iterations of design elements to optimize clarity and persuasiveness.
    Seek out feedback from copywriter, team members, and legal reviewers for graphic assets in a timely manner in order to allow for revisions and re-iterations.
    Proactively seek ways to optimize the development and design process.
    A strong grasp of HTML, CSS.
    A beginners grasp of JavaScript/Jquery.
    Understanding of Mobile First Responsive design concepts.
    Understanding of page speed optimization best practices.
    A strong ability to troubleshoot functional and layout issues.
    Self-driven attention to detail.
    Naturally curious and not afraid to speak up, ask questions or suggest ideas.
    Willingness to learn new systems.
    Openness to re-prioritize and adapt workflow in a fast-paced environment.
    Experience with API intergrations.",
  offered_salary: 4000,
  country: "Singapore",
  company_id: 1,
)

second_job.skills << Skill.first
second_job.skills << Skill.second
second_job.skills << Skill.third
second_job.save

third_job = Job.new(
  title: "Back End Developer",
  description: "We rely on our own enterprise software to give us a competitive advantage over our competition. We’ve built our own marketing platform, project management system, client portal, and more. This is part of what made us the leading agency, and an important part of our strategy for the future.
  We use Trello, Gitlab, Jira, Confluence and Bookstack, and work with the following tech stack:
  Ruby / Ruby on Rails
  Node.js
  Redis, PostgreSQL
  As a back-end developer, you’ll build the enterprise software that helps our company with its primary processes. You’ll work on a project in a small team, depending on the scope of the project. We have daily stand-ups and a scrum session every two weeks, guided by our Scrum Master, where you can present your ideas and work together with the Product Owner to create the best product.",
  offered_salary: 4000,
  country: "Singapore",
  company_id: 1,
)

third_job.skills << Skill.find(6)
third_job.skills << Skill.find(8)
third_job.skills << Skill.find(1)
third_job.skills << Skill.find(4)
third_job.skills << Skill.find(5)
third_job.save

# Create a bunch of fake companies

UserCompany.create(email: Faker::Internet.unique.safe_email, password: Faker::Internet.password)
company = Company.last
company.name = "Professor Oak Pokémon Research"
company.industry = "Pokémon Research"
company.size = size_string[0]
company.save

pokemon_job = Job.new(
  title: "Pokemon Trainer",
  description: "A Pokémon Trainer (Japanese: ポケモントレーナー Pokémon Trainer) is a person who catches, trains, cares for, and battles with Pokémon. The majority of people within the known Pokémon world are Trainers.

Pokémon Trainer is a broad term for any person who owns Pokémon, including Coordinators and Breeders. However, the term is more often used to refer to people on a journey to collect Gym Badges and enter the Pokémon League.

Professor Oak required a pokemon trainer to help capture pokemon for him to study how they can be turned into candy."
)
pokemon_job.skills << Skill.find(16)
pokemon_job.save

UserCompany.create(email: Faker::Internet.unique.safe_email, password: Faker::Internet.password)
company = Company.last
company.name = "Froogal"
company.industry = "Cost effective internet research"
company.size = size_string[3]
company.save

2.times do
  UserCompany.create(email: Faker::Internet.unique.safe_email, password: Faker::Internet.password)
  company = Company.last
  company.name = Faker::Company.name
  company.industry = Faker::Company.industry
  company.size = size_string.sample
  company.save
end

UserCandidate.create(
  email: Faker::Internet.unique.safe_email,
  password: Faker::Internet.password
)
ash_ketchum = Candidate.last
ash_ketchum.given_name = "Ash"
ash_ketchum.family_name = "Ketchum"
ash_ketchum.years_of_experience = 1
ash_ketchum.expected_salary = 1000
ash_ketchum.bio = "I want to be the very best!

In the original series, though Ash actively took part in battles, he was rarely seen independently training his Pokémon. However, since the Advanced Generation series, Ash is shown training more noticeably, having practice battles with his friends and focusing on moves, techniques, and strategies with his Pokémon. A noticeable trait of Ash's is his willingness to learn from both his victories and defeats. For example, after winning in a Gym battle against Winona in Sky High Gym Battle! and witnessing her Pokémon's powerful Aerial Ace, Ash was motivated to have his Swellow learn it. Even his losses can inspire him, such as when he lost to Clayton in Short and To the Punch! and decided to teach his Buizel one of the moves Clayton's Mr. Mime had used during their battle. He believes nothing he and his Pokémon do on their journey is a waste of time."
ash_ketchum.skills << Skill.find_by(name: "Pokémon")
ash_ketchum.skills << Skill.first
ash_ketchum.skills << Skill.second
ash_ketchum.skills << Skill.third
ash_ketchum.save

UserCandidate.create(
  email: Faker::Internet.unique.safe_email,
  password: Faker::Internet.password
)
jessie = Candidate.last
jessie.given_name = "Jessie"
jessie.years_of_experience = 10
jessie.expected_salary = 5000
jessie.bio = "When I am not chasing around pre-adolescent kids and trying to steal their pets, I am also an experienced front-end developer.

When she was old enough, she left home to become a Pokémon nurse. However, she was unable to go to a regular nursing school and went to the Pokémon Nurse School, which was intended for Chansey. She was quite skilled at things such as bandaging, and even showed a Chansey how to do it. She quickly became good friends with that Chansey. However, because she was not a Chansey herself, Jessie couldn't do things like use Sing to soothe Pokémon, instead falling asleep herself. Ultimately, she failed to graduate, and on graduation day, she simply packed a bag and left. As she was leaving, Chansey came up to her and offered her her nurses' hat, but Jessie refused to take it. Chansey then broke her egg-shaped pendant she got as proof of graduating in half and gave one half to Jessie so that they would have something to remember each other by. In the episode Ignorance is Blissey, Jessie was reunited with that same Chansey, which had since evolved into a Blissey. "
jessie.skills << Skill.find_by(name: "Pokémon")
jessie.skills << Skill.first
jessie.skills << Skill.second
jessie.skills << Skill.third
jessie.save

UserCandidate.create(
  email: Faker::Internet.unique.safe_email,
  password: Faker::Internet.password
)
meowth = Candidate.last
meowth.given_name = "Meowth"
meowth.years_of_experience = 3
meowth.expected_salary = 2500
meowth.bio = "Meowth!

I happen to be particularly skilled in back end development. Meowth!

Meowth has an ambitious, conniving, and idealistic personality. He has made it his life goal to please his boss, Giovanni, and will stop at nothing to capture or steal Pokémon, especially Ash's Pikachu, which he has been pursuing since Pokémon Emergency.

Meowth is a characteristically jealous individual, particularly towards other cat Pokémon such as Giovanni's Persian and Matori's own Meowth. He often clashes with them because they are equally as smug and conniving as himself. Many of his personality traits are typical for other Meowth, where they have an affinity for affection, but he has an eye for sparkling objects. Unlike most other Pokémon, who are not truly evil and will only commit evil deeds when ordered to do so, as stated by Jessie's Ekans in Island of the Giant Pokémon, Meowth is both perfectly capable of and willing to commit evil deeds without the aid of others. He is motivated by self-interest and greed, but also enjoys the thrill of taking advantage of others."
meowth.skills << Skill.find(6)
meowth.skills << Skill.find(8)
meowth.skills << Skill.find(1)
meowth.skills << Skill.find(4)
meowth.skills << Skill.find(5)
meowth.save

no_of_companies = Company.all.length - 1

20.times do
  newJob = Job.new(
    title: Faker::Job.title,
    description: Faker::Lorem.paragraph,
    offered_salary: Faker::Number.number(digits: 4).to_s,
    country: "Singapore",
    company_id: rand(no_of_companies) + 1
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

# 20 new candidates with random profiles n stuff
20.times do
  UserCandidate.create(
    email: Faker::Internet.unique.safe_email,
    password: Faker::Internet.password
  )
  candidate = Candidate.last
  candidate.given_name = Faker::Name.first_name
  candidate.family_name = Faker::Name.last_name
  candidate.years_of_experience = Faker::Number.number(digits: 1)
  candidate.expected_salary = Faker::Number.number(digits: 4)
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

# Go through each candidate and get them to "match"
# every job that they are able to be matched for.
# Except for our first candidate
candidates = Candidate.where("id > ?", 1)
jobs = Job.all

candidates.each do |candidate|
  jobs.each do |job|
    match = true
    job.skills.each do |skill|
      if candidate.skills.include? skill
        next
      else
        match = false
        break true
      end
    end
    if match == true
      number = rand 2
      if number == 0
        Match.create(
          job_id: job.id,
          candidate_id: candidate.id,
          candidate_like: true
        )
      elsif number == 1
        Match.create(
          job_id: job.id,
          candidate_id: candidate.id,
          candidate_like: false
        )
      end
    end
  end
end
