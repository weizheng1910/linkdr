class Match < ApplicationRecord
  belongs_to :job
  belongs_to :candidate
  has_one :room
  validates :job_id, uniqueness: { scope: :candidate_id }

  after_create :init_room

  def init_room
    self.build_room.save(validate: false)
  end
end
