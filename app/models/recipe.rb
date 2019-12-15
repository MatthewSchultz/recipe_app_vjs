class Recipe < ApplicationRecord
  enum cuisine: {
    American: 1,
    Italian: 2,
    Mexican: 3,
    Asian: 4,
    Other: 5
  }
end
