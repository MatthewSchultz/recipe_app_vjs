class CreateRecipeIngrediants < ActiveRecord::Migration[6.0]
  def change
    create_table :recipe_ingrediants, id: :uuid do |t|
      t.references :recipe, null: false, foreign_key: true, type: :uuid
      t.references :ingrediant, null: false, foreign_key: true, type: :uuid
      t.decimal :qty, null: false, precision: 3
      t.integer :unit, null: false, limit: 1

      t.timestamps
    end
  end
end
