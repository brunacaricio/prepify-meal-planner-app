class RecipesController < ApplicationController
  def index
    @recipes = Recipe.all

    if params[:query].present?
      @recipes = Recipe.global_search(params[:query])
    end
  end

  def show
    @recipe = Recipe.find(params[:id])
  end
end
