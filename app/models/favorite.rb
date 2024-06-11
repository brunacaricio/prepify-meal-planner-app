class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :recipe
  validates :recipe_id, uniqueness: { scope: :user_id, message: 'This recipe is already in your favorites!' }

  include PgSearch::Model
  pg_search_scope :global_search,
                  associated_against: {
                    recipe: %i[title category]
                  },
                  using: {
                    tsearch: { prefix: true }
                  }
end
