require 'pry'
require 'rest-client'
require 'json'
require_relative '../config/environment'


TEST_URL = "https://api.spoonacular.com/recipes/random/?apiKey=99f8e9d43fb8450b981d1e9a3a659d50"
def run
    puts "Key in your first name"
    user_input = get_user_input()
    if user_input == "exit"
        puts "Goodbye!"
    else
        # verify valid user
        user_login(user_input)
    end
   
end

def get_user_input
    gets.chomp
end

def user_login(logged_in_user)
    user = User.get_user(logged_in_user)
    # binding.pry
    if user
        puts "Hello #{user.first_name}"
    else
        puts "User does not exist."
    end
end




#make a request to the spoonular api using 
#vegetarian, pescetarian, no dietary restriction
# spoonacular_url = "https://api.spoonacular.com/recipes/search"
# test_url = "https://api.spoonacular.com/recipes/random/?apiKey=99f8e9d43fb8450b981d1e9a3a659d50"



# def build_url(input)
#     url = "#{spoonacular_url}#{input}"
#     return url
# end

def make_request(test_url)
        response = RestClient.get(test_url)
        ingredient_array = JSON(response)["recipes"][0]["extendedIngredients"]  
        get_ingredient_array(ingredient_array)
       binding.pry
end 

def get_ingredient_array(ingredient_array)

    # 1) recipe_name = find the name of the recipe
    # 2) cost = find cost
    ingredient_array.select do |k|
        binding.pry
    end
  
 end 

make_request(TEST_URL)
#Recipe.new(name: "", ingredient: k["original"])
#     ingredient_array.select {|k,v| k == "original"}
#     binding.pry
