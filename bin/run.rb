require_relative '../config/environment'
require 'pry'

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

run

