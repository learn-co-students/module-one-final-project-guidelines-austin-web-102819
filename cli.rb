require 'rest-client'
require 'json'
require 'pry'

def welcome_user
    puts "Welcome to Ticketmaster Lite!"
    puts "==========================="
    6.times do
        puts
    end  


end 

def get_input
    gets.chomp
end

def login_or_create_user
    puts "Do you have an account with us?
        (y/n)"
    input = get_input
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
    puts "Please enter your username?"
    username = get_input
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
    puts "Create a username:"
    username = gets.chomp
    if User.find_by(username: username)
        puts "Sorry, that username is taken! Be more .uniq, playa."
        create_user
        puts ' '
    else
    logged_in_user = User.create(username: username)
    puts "Welcome #{username}!"
    $logged_in = logged_in_user.id
    end
end 


def present_menu_options
    puts ' '
    puts '1. search for events by city'
    puts '2. search for events by performer'
    puts '3. pick an event for me'
    puts '4. host an event'
    puts '5. view my event calander'
    puts '6. exit'
    puts ' '

end 

def search_for_all_events
    
end


    # $key = pyLDDCYURYJ8LZfAUnOayESRsPBTWnKM
    # response = RestClient.get
    # EVENTBRITE_API_BASE_URL = response_string = RestClient.get('https://app.ticketmaster.com/discovery/v2/events.json?apikey='+ $key + '&city=' + city + '&size=25&localStartDateTime=' + date + 'T00:00:00,' + date + 'T23:59:59')
    # response_hash = JSON.parse(response_string)

def run
welcome_user
login_or_create_user
present_menu_options

end 

