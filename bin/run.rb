require_relative '../config/environment'
require 'pry'

def run
    puts_to_screen("*****Welcome to Epicure Meal Planner*****\nKey in your first name")
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
    user = User.get_user(logged_in_user)
    # binding.pry
    if user
        puts_to_screen("Hello #{logged_in_user}. Do you want to have the same meal? (YES/NO)")
        user_input = get_user_input()

        case user_input.downcase
        when "yes"
            # puts out the previous meal
            display_meal
        when "no"
            # get and delete current meal and re-plan new meal
            meal = get_existing_meal(user)
            delete_existing_meal(meal)
            diet_preference(user)
        else
            puts_to_screen("Invalid input.")
        end 

    else
        puts_to_screen("User does not exist.")
    end
end

def puts_to_screen(message)
    puts message
end

def display_meal
    puts_to_screen("Here is your meal! Bon appetit!")
    puts_to_screen("Goodbye!")
end

def get_existing_meal(user)
    meal = user.get_meal_by_user
end

def delete_existing_meal(meal)
    puts "meal deleted"
end

def diet_preference(user)
    puts_to_screen("Your diet preference is #{user.diet_preference}. Do you want to change it? (YES/NO)")
    user_input_for_diet_preference = get_user_input()

    case when user_input_for_diet_preference.downcase
    when "yes"
        puts_to_screen("***** Enter 1 or 2 to select your diet preference *****\n1. Vegetarian\n 2. Non-Vegetarian")
        user_input = get_user_input()
        case user_input.downcase
        when "1"
            # user.diet_preference
        when "2"
        else
            puts_to_screen("Invalid input")
        end

        # update diet preference
        user.save
        # generate meal
    when "no"
    else
        puts_to_screen("Invalid input.")
    end
end

# def make_request(test_url)
#     # binding.pry
#     response = RestClient.get(test_url)
#     parsed_response = JSON(response)
#     binding.pry
# end

# TEST_URL = "https://api.spoonacular.com/recipes/random/?apiKey=99f8e9d43fb8450b981d1e9a3a659d50"

# make_request(TEST_URL)

run

