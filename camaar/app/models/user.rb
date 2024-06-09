class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable

  has_many :matriculas
  has_many :turmas, through: :matriculas

  # Add the role attribute (replace with your desired role types)
  enum role: [:admin, :user]  # This defines roles as 'admin' or 'user'
end
