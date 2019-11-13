require 'pry'

# Output welcome message
def welcome
puts "Welcome to the WordBank App!"
puts "==========================="
end
#Username creation

def user_name #This is working on the User model
    puts "Please create a username to create your account:"
    puts "==================================="
    name= gets.chomp
    puts "Your ussername is: #{name}"
    user_object = User.create(name: name)
    puts "Thanks for opening an account with WordBank!"
    puts "====================================="
    user_object
end

def search_word #this is working on the Word model
    puts "You can now search for any word. Enter your word below and hit 'Enter'"
    word = gets.chomp
    word_object = Word.find_by(:word => word) 
    puts "==========================="
    puts "Definition of #{word}: #{word_object.definition}"
    word_object
    
end

def save_word ( nombre , werd )#this is working on BOTH models. We need to chain the methods by passing them as arguments here. 
    puts "Would you like to save this to your WordBank? (y/n)"
    answer= gets.chomp
    
    if answer == "y"
        WordList.create(user_id: nombre.id , word_id: werd.id) #need to find a way to have the results from #search_word and #user_name input into the DB
        

    else
        puts "Search again"
        search_word
    end
end

# This works when we put all the work inside the user_name method.
# This is because the save_word method cannot access the variables in user_name and search_word
# Next steps: Chain the methods together by passing in the first two methods as arguments: save_word(user_name, search_word)