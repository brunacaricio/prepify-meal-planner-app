class AddIngredientToGroceryListItem < ActiveRecord::Migration[7.1]
  def change
    add_reference :grocery_list_items, :ingredient, foreign_key: true

  end
end
