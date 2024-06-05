class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    @recipes = Recipe.all

    if params[:query].present?
      sql_subquery = "recipes.title ILIKE :query OR recipes.category ILIKE :query OR ingredients.name ILIKE :query"
      @recipes = Recipe.joins(:ingredients).where(sql_subquery, query: "%#{params[:query]}%")
    end
  end
end
