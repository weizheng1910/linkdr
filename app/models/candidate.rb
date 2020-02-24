class Candidate < ActiveRecord::Base
	belongs_to :user_candidate
	has_and_belongs_to_many :skills, -> { distinct }
	has_many :matches
	# Commented out unless we need the relation heading back
	# belongs_to :user_candidate

	after_save :validate_skills

	def full_name()
		return given_name + " " + family_name
	end

	def validate_skills
    if self.skills.length > 10
      self.errors.add(:skills, "cannot have more than 10 skills")
      return false
    end
	end
end
