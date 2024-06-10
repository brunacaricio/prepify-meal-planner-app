class PlannedMeal < ApplicationRecord
  belongs_to :user
  belongs_to :recipe
  has_many :grocery_list_items, dependent: :destroy
end
