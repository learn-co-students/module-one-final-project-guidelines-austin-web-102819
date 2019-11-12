# require_relative './models/user.rb'

require 'pry'
# Output welcome message
puts "Welcome to the WordBank App!"
#Username creation

def user_name
    puts "Please create a username to create your account:"
    name= gets.chomp
    puts "Your username is: #{name}"
    User.create(name: name)
    name
end



# Save the Username
# def save_name(user_name)
#     User.create(name: user_name)
# end