class Recipe < ApplicationRecord
  has_many :recipe_ingredients
  has_many :ingredients, through: :recipe_ingredients
  has_many :favorites

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
