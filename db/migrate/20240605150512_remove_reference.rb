class RemoveReference < ActiveRecord::Migration[7.1]
  def change
    remove_reference(:recipe_ingredients, :grocery_list_item, index: false)
  end
end
