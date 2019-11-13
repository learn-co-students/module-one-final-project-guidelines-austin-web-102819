require 'pry'
require 'rest-client'
require 'json'
require_relative '../config/environment'


TEST_URL = "https://api.spoonacular.com/recipes/random/?apiKey=99f8e9d43fb8450b981d1e9a3a659d50"
def run
    puts_to_screen("***** Welcome to Epicure Meal Planner *****\nKey in your first name")
    user_input = get_user_input()
    
    if user_input.downcase == "exit"
        puts_to_screen("Goodbye!")
    else
        # verify valid user
        user_login(user_input)
    end
   
end

def get_user_input
    gets.chomp
end

def user_login(logged_in_user)
    # binding.pry
    user = User.get_user(logged_in_user)
    
    if user
        puts_to_screen("Hello #{logged_in_user}. Do you want to have the same meal? (YES/NO)")
        user_input = get_user_input()

        case user_input.downcase
        when "yes"
            meal = get_existing_meal(user)
        when "no"
            # get and delete current meal and find new meal
            meal = get_existing_meal(user)
            delete_existing_meal(user)
            show_diet_preference(user)
            meal = find_meal
        else
            puts_to_screen("Invalid input.")
        end 
        
        display_meal(user)
        
    else
        puts_to_screen("User does not exist.")
    end
end

def puts_to_screen(message)
    puts message
end

def display_meal(user)
    
    meal = user.display_meal
    # binding.pry
    if meal
        i = 0
        puts_to_screen("Here is your meal! Bon appetit!\n")
        puts_to_screen("*** #{meal[0].name}\n")
        meal.size.times do
            puts_to_screen("\t#{meal[i].ingredient}\n")
            i += 1
        end

        puts_to_screen("*** Cost per serving: #{meal[0].cost}\n")
    else
        puts_to_screen("You have no saved meal!\n")
    end
    puts_to_screen("Goodbye!")
end

def get_existing_meal(user)
    meal = user.get_meal_by_user
end

def delete_existing_meal(user)
    user.delete_meal
end

def show_diet_preference(user)
    puts_to_screen("Your diet preference is #{user.diet_preference}. Do you want to change it? (YES/NO)")
    user_input_for_diet_preference = get_user_input()

    case user_input_for_diet_preference.downcase
    when "yes"
        puts_to_screen("Enter 1. Vegetarian or 2. Non-Vegetarian (1/2)")
        user_input = get_user_input()
        case user_input.downcase
        when "1"
            user.diet_preference = "vegetarian"
            puts_to_screen("You selected 1. Vegetarian")
        when "2"
            user.diet_preference = "non-vegetarian"
            puts_to_screen("You selected 2. Non-Vegetarian")
        else
            puts_to_screen("Invalid input")
        end

        user.update
        
    when "no"
        
    else
        puts_to_screen("Invalid input.")
    end

    find_meal
end

def find_meal
    # TODO: find meal
end

#make a request to the spoonular api using 
#vegetarian, pescetarian, no dietary restriction
# test_url = "https://api.spoonacular.com/recipes/random/?apiKey=99f8e9d43fb8450b981d1e9a3a659d50"


def make_request(test_url)
        response = RestClient.get(test_url)
        ingredient_array = JSON(response)["recipes"][0]["extendedIngredients"]  
        get_ingredient_array(ingredient_array)
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
