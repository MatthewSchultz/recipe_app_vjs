class RecipeIngrediant < ApplicationRecord
  belongs_to :recipe
  belongs_to :ingrediant, optional: true # must be optional, since ingredient is set after validation.

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
    bunch: 11,
    oz: 12
  }

  validates :unit, presence: true, inclusion: {in: RecipeIngrediant.units}
  validates :qty, presence: true
  validates :ingredient_name, presence: true, length: 1..255

  before_save :set_ingredient # don't use after_validate, since this should be atomic

  # Cannot do this, see GH-10
  #accepts_nested_attributes_for :ingrediant

  def ingredient_name
    @ingredient_name || self.ingrediant.name
  end

  def ingredient_name=(i_name)
    @ingredient_name = i_name

    # required, or else it won't call the callback:
    ingrediant_id_will_change!
  end

  protected

  def set_ingredient
    # if name has been written to, change the ingrediant:
    self.ingrediant = Ingrediant.find_or_create_by(name: @ingredient_name) if @ingredient_name
  end
end
