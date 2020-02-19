class Candidate < ActiveRecord::Base
	belongs_to :user_candidate
	has_and_belongs_to_many :skills,  -> { distinct, limit: 10 }
	has_many :matches
	# Commented out unless we need the relation heading back
	# belongs_to :user_candidate
	validates :bio, length: { maximum: 500 }
end
