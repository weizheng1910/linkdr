class Candidate < ActiveRecord::Base
	has_and_belongs_to_many :skills
	# Commented out unless we need the relation heading back
	# belongs_to :user_candidate
end
