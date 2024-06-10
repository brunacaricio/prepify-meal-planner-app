class Recipe < ApplicationRecord
  has_many :recipe_ingredients, dependent: :destroy
  has_many :ingredients, through: :recipe_ingredients
  has_many :favorites, dependent: :destroy
  has_many :planned_meals, dependent: :destroy


  validates :title, :category, :description, :instructions, :total_time, :servings, :score, :image, presence: true

  include PgSearch::Model
  pg_search_scope :global_search,
                  against: %i[title category],
                  associated_against: {
                    ingredients: :name
                  },
                  using: {
                    tsearch: { prefix: true }
                  }
end
