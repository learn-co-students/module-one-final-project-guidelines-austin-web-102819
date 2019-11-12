# require_relative './models/user.rb'

require 'pry'
# Output welcome message
puts "Welcome to the WordBank App!"
#Username creation

def user_name
    puts "Please create a username to create your account:"
    name= gets.chomp
    puts "Your ussername is: #{name}"
    User.create(name: name)
    puts "Thanks for opening an account with WordBank!"
    name
end

def search_word
    puts "You can now search for any word. Enter your word below and hit 'Enter'"
    word = gets.chomp
    result= Word.find_by(:word => word)
    puts "*****************************"
    puts "Definition of #{word}: #{result.definition}"
end




# Save the Username
# def save_name(user_name)
#     User.create(name: user_name)
# end