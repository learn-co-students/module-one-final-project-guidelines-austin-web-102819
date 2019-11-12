require 'pry'

class User < ActiveRecord::Base
    has_many :meals
    has_many :recipes, through: :meals

    def self.get_user(first_name)
        # binding.pry
        User.find_by(first_name: first_name.downcase)
    end
end