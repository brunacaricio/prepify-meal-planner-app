class Recipe < ApplicationRecord
  has_many :recipe_ingredients
  has_many :ingredients, through: :recipe_ingredients
  has_many :favorites

  validates :title, :category, :description, :instructions, :total_time, :servings, :score, :image, presence: true
end
