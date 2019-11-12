def welcome_user
    puts "Welcome to Eventbrite Lite!"
    puts "======================================="
end 

def login_or_create_user
    puts "Do you have an account with us?
        (y/n)"
    input = gets.chomp
    if input == 'y'
        login_user
    elsif input == 'n'
        create_user
    else 
        puts "Please type valid response."
        login_or_create_user
    end 
end 

def login_user
    puts "What is your username?"
    username = gets.chomp
    puts "Welcome back #{username}!"
end 

def create_user
    puts "Create a username: "
    username = gets.chomp
    User.create(username: username)
    puts "Welcome #{username}!"
end 

def present_menu_options
    puts "1. search for all events
          2. search for free events
          3. pick an event for me 
          4. host an event
          5. view my event calander
          6. exit"
end 


def run
welcome_user
login_or_create_user
present_menu_options
end 

run