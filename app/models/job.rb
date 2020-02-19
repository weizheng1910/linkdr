class Job < ApplicationRecord
  belongs_to :company
  has_many :matches
  has_and_belongs_to_many :skills
  
end
