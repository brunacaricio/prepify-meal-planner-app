class AddRecipeTitleAndIngredientNameToRecipeIngredients < ActiveRecord::Migration[7.1]
  def change
    add_column :recipe_ingredients, :recipe_title, :string
    add_column :recipe_ingredients, :ingredient_name, :string

  end
end
