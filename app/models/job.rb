class Job < ApplicationRecord
  belongs_to :company
  has_many :matches
  has_and_belongs_to_many :skills, -> { distinct }

  after_save :validate_skills

  def validate_skills
    if self.skills.length > 5
      self.errors.add(:skills, "cannot have more than 5 skills to a job")
      return false
    end
  end

  def country_name
    self.country = ISO3166::Country[country]
  end
end
