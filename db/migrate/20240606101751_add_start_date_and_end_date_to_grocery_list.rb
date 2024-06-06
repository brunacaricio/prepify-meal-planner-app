class AddStartDateAndEndDateToGroceryList < ActiveRecord::Migration[7.1]
  def change
    add_column :grocery_lists, :start_date, :date
    add_column :grocery_lists, :end_date, :date
  end
end
