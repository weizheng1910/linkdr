class Job < ApplicationRecord
  belongs_to :company
  has_many :matches
end
