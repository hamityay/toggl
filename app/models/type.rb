class Type < ApplicationRecord
  # relations
  has_many :timers, dependent: :nullify

  # Validations
  validates_presence_of :name
end
