class Company < ApplicationRecord
  belongs_to :user_company, optional: true
  has_many :job

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
end
