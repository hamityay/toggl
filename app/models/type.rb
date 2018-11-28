class Type < ApplicationRecord
  # relations
  has_many :timers, dependent: :nullify
end
