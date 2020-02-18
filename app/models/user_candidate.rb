class UserCandidate < ApplicationRecord
  belongs_to :candidate, optional: true
  after_create :init_candidate

  def init_candidate
    self.build_candidate.save(validate: false)
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
