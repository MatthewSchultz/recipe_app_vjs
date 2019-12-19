class ChangeQtyOnRecipeIngredients < ActiveRecord::Migration[6.0]
  def change
    change_column :recipe_ingredients, :qty, :decimal, precision: 10, scale: 2
  end
end
