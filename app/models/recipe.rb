class Recipe < ActiveRecord::Base
    has_many :meals
    has_many :users, through: :meals
end 

#make a request to the spoonular api using 
#vegetarian, pescetarian, no dietary restriction
