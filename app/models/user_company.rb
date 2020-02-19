class UserCompany < ApplicationRecord
  has_one :company
  after_create :init_company

  def init_company
    self.build_company.save(validate: false)
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one :company
end
