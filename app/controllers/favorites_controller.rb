class FavoritesController < ApplicationController
  def index
    @favorites = Favorite.all

    if params[:query].present?
      @favorites = Favorite.global_search(params[:query])
    end

    @planned_meal = PlannedMeal.new
  end

  def create
    @recipe = Recipe.find(params[:recipe_id])

    @favorite = Favorite.new(recipe: @recipe, user: current_user)
    if @favorite.save!
      redirect_to request.referrer, notice: 'Successfully saved to favorites!'
    else
      flash.now[:alert] = 'Your recipe could not be added to the calendar...'
      redirect_to request.referrer, notice: 'Your recipe could not be added to the calendar...'
    end
  end

  def destroy
    @favorite = current_user.favorites.find(params[:id])
    @favorite.destroy
    redirect_to request.referrer, notice: 'Recipe successfully deleted!'
  end
end
