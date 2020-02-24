# Linkdr

![logo](/public/small-logo.png)

Linkdr is where people hire software developers. Like in real life, but better.

## The App

In this day and age where technology is prevalent, tech companies are constantly hiring. For tech recruiters who are scuttling around trying to match relevant candidates to their available jobs, they simply have no time manually read through bloated resumes.

Our app aims to streamline the hiring process for tech companies or recruiters, only asking for relevant details from candidates. No more wordy cover letters which no one bothers to read anyway or repeated details being asked!

### How It Works

- Tech recruiters or companies will be able to:
  - Post job listings
  - Screen relevant candidates for respective listings
  - Reach out to candidates after you get LINKD via our in-app chat system or by direct email

- Candidates will be able to:
  - View relevant job listings
  - Express interest in jobs
  - Sit back and wait for companies to approach!

## APIs
- **[Cloudinary](https://cloudinary.com/)** - File hosting & upload
- **[Gravatar](https://en.gravatar.com/)** - User/candidate avatars

### Installation Instructions
Linkdr requires PostgreSQL 10.5 and Redis 5.0.7 to be installed globally
```
bundle install
rails db:create
rails db:migrate
rails db:seed
rails server
redis-server
```


## Application Development Process
### Built With
- **[Ruby 2.5.1](https://www.ruby-lang.org/en/)** - Main Language
- **[Rails 5.2.4.1](https://rubyonrails.org)** - Backend Framework
- **[PostgreSQL 10.5](https://www.postgresql.org/)** - SQL Database
- **[Redis 5.0.7](https://redis.io/)** - Chat/Messaging Database
- **[Bootstrap](https://getbootstrap.com/)** - Frontend Framework

### General Approach
- brainstormed a couple of ideas and narrowed it down to creating an app for tech recruiters + job seekers
- identified problems for users
- came up with personas and their user story
- whiteboarding our user flows and wireframes
- whiteboarding ERD to determine how data needs to be stored and how they are referencing other databases
- disseminate features to each team member
- built app in sprints and ran user tests for feedback
- debugged, more testing and added more features

### Major Hurdles in building the app.
- combining two database systems (PostgreSQL and Redis)
- external files/APIs with cloudinary - especially sharing keys & functionality across team members
- organising work as a team
- sorting database and results, pairing candidates with suitable roles
- having two devises user models (one for candidates and one for companies)
  - managing different views for pages between what candidates would see and what companies would see.

## Acknowledgements

- **[Art Illustrations](https://mixkit.co/free-stock-art/)**
- **[Icons](https://material.io/resources/icons/?style=baseline)**

## Team

- [Stu](https://github.com/LaustinSpayce)
- [Ben](https://github.com/benjacoblee)
- [Weizheng](https://github.com/weizheng1910)
- [Rachelle](https://github.com/rachellesg)
