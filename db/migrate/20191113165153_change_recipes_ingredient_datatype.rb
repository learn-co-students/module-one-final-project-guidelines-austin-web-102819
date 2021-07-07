class ChangeRecipesIngredientDatatype < ActiveRecord::Migration[6.0]
  def change
    change_column :recipes, :ingredient, :TEXT
  end
end
