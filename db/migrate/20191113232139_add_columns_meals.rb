class AddColumnsMeals < ActiveRecord::Migration[6.0]
  def change
    add_column :meals, :recipe_name, :string
    add_column :meals, :cost, :float
  end
end
