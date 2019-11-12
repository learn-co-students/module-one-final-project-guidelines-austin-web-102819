# require_relative './models/user.rb'

require 'pry'
# Output welcome message
puts "Welcome to the WordBank App!"
puts "==========================="
#Username creation

def user_name
    puts "Please create a username to create your account:"
    puts "==================================="
    name= gets.chomp
    puts "Your ussername is: #{name}"
    User.create(name: name)
    puts "Thanks for opening an account with WordBank!"
    puts "====================================="
    name
end

def search_word
    puts "You can now search for any word. Enter your word below and hit 'Enter'"
    word = gets.chomp
    result= Word.find_by(:word => word) 
    puts "==========================="
    puts "Definition of #{word}: #{result.definition}"
    result
end

def save_word
    puts "Would you like to save this to your WordBank? (y/n)"
    answer= gets.chomp
    if answer == "y"
        WordList.create(user_id: user , word_id: word) #need to find a way to have the results from #search_word and #user_name input into the DB
        # binding.pry

    else
        puts "Search again"
        search_word
    end
end


# Save the Username
# def save_name(user_name)
#     User.create(name: user_name)
# end