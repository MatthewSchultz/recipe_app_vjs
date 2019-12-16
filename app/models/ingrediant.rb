class Ingrediant < ApplicationRecord
  validates :title, presence: true, uniqueness: true, length: 1..255
end
