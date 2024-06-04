class CreateRecipes < ActiveRecord::Migration[7.1]
  def change
    create_table :recipes do |t|
      t.string :title
      t.string :category
      t.string :description
      t.string :instructions
      t.integer :total_time
      t.integer :servings
      t.integer :score
      t.string :image
      t.string :diet

      t.timestamps
    end
  end
end
