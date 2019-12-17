class Ingrediant < ApplicationRecord
  validates :name, presence: true, uniqueness: true, length: 1..255
end
