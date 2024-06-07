class RecipesController < ApplicationController
  def index
    @recipes = Recipe.all

    if params[:query].present?
      @recipes = Recipe.global_search(params[:query])
    end

    @planned_meal = PlannedMeal.new

  end

  def show
    @recipe = Recipe.find(params[:id])
    @planned_meal = PlannedMeal.new
  end
end
