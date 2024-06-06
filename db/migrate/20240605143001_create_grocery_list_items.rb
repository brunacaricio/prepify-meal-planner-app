class CreateGroceryListItems < ActiveRecord::Migration[7.1]
  def change
    create_table :grocery_list_items do |t|
      t.integer :total_amount
      t.boolean :bought
      t.references :grocery_list, null: false, foreign_key: true

      t.timestamps
    end
  end
end
