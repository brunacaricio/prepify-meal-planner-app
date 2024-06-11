class GroceryListsController < ApplicationController
  def index
    if current_user.grocery_lists.exists?

      @grocery_list = current_user.grocery_lists.last
      @aisle_hash = @grocery_list.grocery_list_items.group_by do |item|
        ingr = Ingredient.find_by(id: item.ingredient_id)
        ingr.aisle
      end
    else
      @grocery_list = GroceryList.new
      @grocery_list.user = current_user
      @grocery_list.save!
    end
  end

  def update
    @grocery_list = current_user.grocery_lists.last
    if @grocery_list.update!(grocery_list_params)
      grocery_list_items(@grocery_list.start_date, @grocery_list.end_date)
    else
      flash.now[:alert] = "Oops, something went wrong !"
    end
    redirect_to grocery_list_path
  end

  def check
    @grocery_list = current_user.grocery_lists.last
    item = Ingredient.find_by(id: item.ingredient_id)
    item.bought = !item.bought
    item.save!
    redirect_to grocery_lists_path
  end

  private

  def grocery_list_params
    attributes = {}
    permitted_params = params.require(:grocery_list).permit(:start_date)

    attributes[:start_date] = permitted_params[:start_date].gsub(/ to .*/, "").to_date
    attributes[:end_date] = permitted_params[:start_date].gsub(/.* to /, "").to_date
    return attributes
  end

  def grocery_list_items(start_date,end_date)
    current_user.grocery_lists.last.grocery_list_items.destroy_all
    planned_meals = current_user.planned_meals.where(date: start_date..end_date)
    planned_meals.each do |meal|
      meal.recipe.recipe_ingredients.each do |recipe_ingredient|
        i = Ingredient.find_by(id: recipe_ingredient.ingredient.id)
        if current_user.grocery_lists.last.grocery_list_items.find_by(ingredient_id: i.id).nil?
          item = GroceryListItem.new(recipe_ingredient_id: recipe_ingredient.id, bought: false, total_amount: recipe_ingredient.quantity)
          ing = Ingredient.find_by(id: recipe_ingredient.ingredient_id)
          item.ingredient_id = ing.id
          item.grocery_list = current_user.grocery_lists.last
          item.planned_meal_id = meal.id
          item.save!
        else
          item = current_user.grocery_lists.last.grocery_list_items.find_by(ingredient_id: i.id)
          item.update(total_amount: item.total_amount += recipe_ingredient.quantity)
        end
      end
    end
  end
end
