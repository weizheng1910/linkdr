class Company < ApplicationRecord
  belongs_to :user_company
  has_many :job

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
end
