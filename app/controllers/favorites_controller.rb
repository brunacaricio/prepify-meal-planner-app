class FavoritesController < ApplicationController
  def index
    @favorites = Favorite.all
    @recipes = Recipe.all
  end

  def create
    @recipe = Recipe.find(params[:recipe_id])

    @favorite = Favorite.new(recipe: @recipe, user: current_user)
    @favorite.save
  end

  def destroy
  end
end
