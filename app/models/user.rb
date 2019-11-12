require 'pry'

class User < ActiveRecord::Base
    has_many :meals
    has_many :recipes, through: :meals


    def self.get_user(first_name)
        User.find_by(first_name: first_name.downcase)
    end

    def get_meal_by_user
        binding.pry
        self.meals.all
    end

    def update
        self.save
    end
end