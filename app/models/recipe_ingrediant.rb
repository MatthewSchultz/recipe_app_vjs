class RecipeIngrediant < ApplicationRecord
  belongs_to :recipe
  belongs_to :ingrediant

  enum unit: {
    cups: 1,
    tbspn: 2,
    tspn: 3,
    qt: 4,
    gallon: 5,
    ml: 6,
    liter: 7,
    pieces: 8,
    pinch: 9,
    bag: 10,
    bunch: 11
  }

  validates :unit, presence: true, inclusion: {in: RecipeIngrediant.units}
  validates :qty, presence: true

  accepts_nested_attributes_for :ingrediant
end
