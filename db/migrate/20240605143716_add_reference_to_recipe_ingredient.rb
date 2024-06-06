class AddReferenceToRecipeIngredient < ActiveRecord::Migration[7.1]
  def change
    add_reference :recipe_ingredients, :grocery_list_item, foreign_key: true
  end
end
