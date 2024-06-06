class CreatePlannedMeals < ActiveRecord::Migration[7.1]
  def change
    create_table :planned_meals do |t|
      t.date :date
      t.references :user, null: false, foreign_key: true
      t.references :recipe, null: false, foreign_key: true

      t.timestamps
    end
  end
end
