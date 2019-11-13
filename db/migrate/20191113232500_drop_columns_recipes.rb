class DropColumnsRecipes < ActiveRecord::Migration[6.0]
  def change
    remove_column :recipes, :name
    remove_column :recipes, :cost
  end
end
