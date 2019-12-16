class Recipe < ApplicationRecord
  enum cuisine: {
    American: 1,
    Italian: 2,
    Mexican: 3,
    Asian: 4,
    Other: 5
  }

  validates :title, presence: true, uniqueness: true, length: 1..1024
  validates :cuisine, presence: true, inclusion: {in: Recipe.cuisines.keys.map(&:to_s)}
end
