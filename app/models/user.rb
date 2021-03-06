class User < ApplicationRecord
  # relations
  has_many :timers, dependent: :nullify

  # Scopes
  scope :active, -> { where(is_active: true) }
  scope :admin, -> { where(is_admin: true) }

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Validations
  validates_presence_of :username, :email, :password
end
