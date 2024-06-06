class AddRecipeIngredientsReferenceToGroceryListItem < ActiveRecord::Migration[7.1]
  def change
    add_reference :grocery_list_items, :planned_meal, foreign_key: true
    add_reference :grocery_list_items, :recipe_ingredient, foreign_key: true
  end
end
