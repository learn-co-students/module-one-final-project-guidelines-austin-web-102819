class Recipe < ActiveRecord::Base
    has_many :meals
    has_many :users, through: :meals

    # def self.create
    # end

    # def self.create_recipe(ingredient_array)
    #     ingredient_array.each do |i|
    #         binding.pry
    #         Recipe.create(ingredient: i)
    #     end
    # end 
end 

