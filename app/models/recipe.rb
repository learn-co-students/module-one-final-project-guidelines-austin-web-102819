class Recipe < ActiveRecord::Base
    has_many :meals
    has_many :users, through: :meals

    def delete_recipe_by_meal
        # Recipe.meals.all.find_by[]

    end
end 
<<<<<<< HEAD
=======

>>>>>>> 41c601a7b74dba27fb3d4c52d621fa7673691848
