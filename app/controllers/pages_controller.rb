class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    @planned_meal = PlannedMeal.new

    params[:categ] ||= "All"

    if params[:categ].present? && params[:categ] != "All"
      @recipes = Recipe.where("category ILIKE ?", "%#{params[:categ]}%")
    else
      @recipes = Recipe.all.sample(10)
    end
    @categories = ['All', 'Italian', 'South America', 'Thai', 'Mexican', 'American', 'Middle Eastern']
  end
end
