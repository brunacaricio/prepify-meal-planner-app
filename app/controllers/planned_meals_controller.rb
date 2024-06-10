class PlannedMealsController < ApplicationController
  def index
    @planned_meals = current_user.planned_meals

    future_meals = @planned_meals.where.not(date: Date.today..Date.today + 6).order("date ASC")
    @future_meals_hash = future_meals.group_by(&:date)
  end

  def create
    @recipe = Recipe.find(params[:recipe_id])

    @planned_meal = PlannedMeal.new(planned_meal_params)
    @planned_meal.user = current_user
    @planned_meal.recipe = @recipe

    if @planned_meal.save
      respond_to do |format|
        format.html { redirect_to recipes_planned_meals_path }
        format.json { render json: { form: render_to_string(partial: 'recipes/form', formats: [:html], locals: { planned_meal: PlannedMeal.new, recipe: @recipe }) } }
      end
    else
      respond_to do |format|
        format.html { redirect_to recipes_planned_meals_path, status: :unprocessable_entity}
        format.json { render json: { form: render_to_string(partial: 'recipes/form', formats: [:html], locals: { planned_meal: @planned_meal, recipe: @recipe }) } }
      end
    end
  end

  def destroy
    @planned_meal = current_user.planned_meals.find(params[:id])
    @planned_meal.destroy
    redirect_to request.referrer, notice: 'Recipe deleted successfully'
  end

  private

  def planned_meal_params
    params.require(:planned_meal).permit(:date)
  end
end
