class FavoritesController < ApplicationController
  def index
    @favorites = current_user.favorites

    if params[:query].present?
      @favorites = Favorite.global_search(params[:query])
    end

    @planned_meal = PlannedMeal.new
  end

  def create
    @recipe = Recipe.find(params[:recipe_id])
    @favorite = Favorite.new(recipe: @recipe, user: current_user)

    respond_to do |format|
      if @favorite.save
        format.html { redirect_to favorites_path, notice: 'Successfully saved to favorites!' }
        format.json { render json: {form: render_to_string(partial: 'form', formats: [:html], locals: { favorite: Favorite.new, recipe: @recipe}), success: true} }
      else
        format.html { redirect_to favorites_path, notice: 'Your recipe could not be added to the calendar...'}
        format.json { render json: { form: render_to_string(partial: 'form', formats: [:html], locals: { favorite: @favorite, recipe: @recipe })}}
      end
    end
  end

  def destroy
    @favorite = current_user.favorites.find(params[:id])
    @favorite.destroy
    redirect_to request.referrer, notice: 'Recipe successfully deleted!'
  end
end
