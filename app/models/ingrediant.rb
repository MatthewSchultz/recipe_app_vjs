class Ingrediant < ApplicationRecord
  validates :name, presence: true, uniqueness: true, length: 1..255
  has_many :recipe_ingredients, dependent: :destroy
end
