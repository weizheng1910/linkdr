class Match < ApplicationRecord
  belongs_to :job
  belongs_to :candidate
  validates :job_id, uniqueness: { scope: :candidate_id }

  
end
