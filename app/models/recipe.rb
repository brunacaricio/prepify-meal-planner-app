class Recipe < ApplicationRecord
  has_many :ingredients, through: :recipe_ingredients
  has_many :recipe_ingredients

  validates :title, :category, :description, :instructions, :total_time, :servings, :score, :image, presence: true
end
