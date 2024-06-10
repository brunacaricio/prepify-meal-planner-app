class PlannedMealsController < ApplicationController
  def index
    @planned_meals = current_user.planned_meals
  end

  def create
    @recipe = Recipe.find(params[:recipe_id])

    @planned_meal = PlannedMeal.new(planned_meal_params)
    @planned_meal.user = current_user
    @planned_meal.recipe = @recipe

    if @planned_meal.save
      redirect_to planned_meals_path
    else
      # flash[:alert] = 'Your recipe could not be added to the calendar...'
      redirect_to request.referrer, notice: 'Recipe could not be saved - hint: Select a day !'
    end
  end

  def destroy
    @planned_meal = current_user.planned_meals.find(params[:id])
    @planned_meal.destroy
    redirect_to planned_meals_path, notice: 'Recipe deleted successfully'
  end

  private

  def planned_meal_params
    params.require(:planned_meal).permit(:date)
  end
end
