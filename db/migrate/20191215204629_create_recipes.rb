class CreateRecipes < ActiveRecord::Migration[6.0]
  def change
    create_table :recipes, id: :uuid do |t|
      t.string :title, null: false, limit: 1024
      t.integer :cuisine, null: false, limit: 1 # Create a tinyint
      t.datetime :planning_to_cook_on, null: true
      t.boolean :tried_before, null: false
      t.text :instructions, null: false

      t.index :title, unique: true

      t.timestamps
    end
  end
end
