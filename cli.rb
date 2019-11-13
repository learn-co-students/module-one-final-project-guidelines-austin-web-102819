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
    if User.find_by(username: username)
        logged_in_user = User.find_by(username: username)
        puts "Welcome back #{username}!"
        $logged_in = logged_in_user.id
    else 
        puts "Sorry, username does not exist."
        login_or_create_user
    end 
end 

# Method is printing unexpected message :
# D, [2019-11-13T10:55:58.329297 #35501] DEBUG -- :    (1.1ms)  SELECT sqlite_version(*)
# D, [2019-11-13T10:55:58.657780 #35501] DEBUG -- :   User Load (0.3ms)  SELECT "users".* FROM "users" WHERE "users"."username" = ? LIMIT ?  [["username", "Jimbo"], ["LIMIT", 1]]"

def create_user
    puts "Create a username: "
    username = gets.chomp
    if User.find_by(username: username)
        puts "Sorry, that username is taken. Be more .uniq, playa."
        create_user
    else
    logged_in_user = User.create(username: username)
    puts "Welcome #{username}!"
    $logged_in = logged_in_user.id
    end
end 

def present_menu_options
    puts  "1. search for all events
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

