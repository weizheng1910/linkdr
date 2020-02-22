class UserCandidate < ApplicationRecord
  has_one :candidate
  after_create :init_candidate

  def init_candidate
    self.build_candidate.save(validate: false)
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :confirmable, :registerable,
         :recoverable, :rememberable, :validatable

  include Gravtastic
  gravtastic :default => "mm"
end
