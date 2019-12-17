class CreateIngrediants < ActiveRecord::Migration[6.0]
  def change
    create_table :ingrediants, id: :uuid do |t|
      t.string :name, length: 255

      t.index :name, unique: true

      t.timestamps
    end
  end
end
