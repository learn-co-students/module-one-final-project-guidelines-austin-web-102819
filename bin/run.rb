require 'pry'
require 'rest-client'
require 'json'
require_relative '../config/environment'

# require "catpix"

RECIPE_API_URL = "https://api.spoonacular.com/recipes/random/?apiKey=99f8e9d43fb8450b981d1e9a3a659d50&number=1&tags=main%20course,"

def run
    puts_to_screen("***** Welcome to Epicure Meal Planner *****\nKey in your first name")
    user_input = get_user_input()
    
    if user_input.downcase == "exit"
        puts_to_screen("Goodbye!")
    else
        # verify user
        user_login(user_input)
    end
   
end

def get_user_input
    gets.chomp
end

def user_login(logged_in_user)
    user = User.get_user(logged_in_user)
    
    if user
        puts_to_screen("Hello #{logged_in_user}. Do you want to have the same meal? (YES/NO)")
        user_input = get_user_input()

        case user_input.downcase
        when "yes"
            # meal = get_existing_meal(user)
        when "no"
            # get and delete current meal and find new meal
            meal = get_existing_meal(user)
            delete_existing_meal(user)
            show_diet_preference(user)
            # binding.pry
            meal = find_meal(user)
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
        # binding.pry
        puts_to_screen("*** #{user.meals[0].recipe_name}\n")
        meal.size.times do
            puts_to_screen("\t#{meal[i].ingredient}\n")
            i += 1
        end

        puts_to_screen("*** Cost per serving: #{user.meals[0].cost}\n")
        puts_to_screen("Goodbye!")
    else
        puts_to_screen("You have no saved meal! Do you want to find a meal? (YES/NO)")
        user_input = get_user_input

        case user_input.downcase
        when "yes","y"
            show_diet_preference(user)
            meal = find_meal(user)
            display_meal(user)
            puts_to_screen("Goodbye!")
        when "no","n"
            puts_to_screen("Goodbye!")
        end
    end
    # Catpix::print_image "pokemon.png",
    # :limit_x => 1.0,
    # :limit_y => 0,
    # :center_x => true,
    # :center_y => true,
    # :bg => "white",
    # :bg_fill => true
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
    when "yes","y"
        puts_to_screen("Enter [1]. Vegetarian or [2]. Non-Vegetarian (1/2)")
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
        
    when "no","n"
        
    else
        puts_to_screen("Invalid input.")
    end
end

def find_meal(user)
    make_request("#{RECIPE_API_URL}#{user.diet_preference}", user)
end

def make_request(test_url, user)
    response = RestClient.get(test_url)
    parsed_response = JSON(response)
    
    ingredient_array = parsed_response["recipes"][0]["extendedIngredients"]  
    recipe_name = parsed_response["recipes"][0]["title"]
    cost_per_serving = parsed_response["recipes"][0]["pricePerServing"] 
    generate_meal(ingredient_array, recipe_name, cost_per_serving, user)
end 

def generate_meal(ingredient_array, recipe_name, cost_per_serving, user)
    ingredient_array = ingredient_array.map do |k|
                            k["original"]
                        end

    ingredient_array.each do |i|
        ingredient = Recipe.create(ingredient: i)
        meal = Meal.new(user_id: user.id, recipe_name: recipe_name, cost: cost_per_serving)
        meal.recipe = ingredient
        meal.save
    end
end 

run



