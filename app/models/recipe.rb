class Recipe < ActiveRecord::Base
    has_many :meals
    has_many :users, through: :meals

    def delete_recipe_by_meal
        # Recipe.meals.all.find_by[]

    end
end 
