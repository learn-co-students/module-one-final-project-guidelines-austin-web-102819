require 'rest-client'
require 'json'
require 'pry'

def welcome_user
    puts "Welcome to Ticketmaster Lite!"
    puts "==========================="
   space(2)
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
        line
        space(1)
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
    puts "Pick a number. Any number. "
    space(2)
    puts '1. search for events by city'
    puts '2. search for events by performer'
    puts '3. pick an event for me'
    puts '4. host an event'
    puts '5. view my event calander'
    puts '6. exit'
    space(1)
end 

def pick_option
    input = get_input
    if input == '1'
        events_array = search_by_city
        display_events(events_array)
     elsif input == '2'
        events_array = search_by_performer
        display_events(events_array)
    # elsif input == 3
    #     random_event
    # elsif input == 4
    #     create_event
    # elsif input == 5
    #     user.event_planner
    # elsif input == 6
    #     puts "Thank you!"
    else
       puts "Invalid"
       pick_option
    end 
end 

def space(num)
    num.times do
        puts
    end 
end 


def line
    puts "----------------------------"
end 

def search_by_city
    puts "Where would you like to look?"
    city = get_input
    url = "https://app.ticketmaster.com/discovery/v2/events?apikey=pyLDDCYURYJ8LZfAUnOayESRsPBTWnKM&locale=*&city="+ city
    response = RestClient.get(url)
    events = JSON.parse(response)["_embedded"]["events"]
    events_array = events[0...19]
    events_array
end

def search_by_performer
    puts "Where would you like to see?"
    performer = get_input
    url = "https://app.ticketmaster.com/discovery/v2/attractions?apikey=pyLDDCYURYJ8LZfAUnOayESRsPBTWnKM&keyword="+ performer +"&locale=*"
    response = RestClient.get(url)
    binding.pry
    events = JSON.parse(response)["_embedded"]["events"]
    events_array = events[0...19]
    events_array
end

def display_events(events_array)
    events_array do |event|
        line
        p event["name"]
        p event ["dates"]["start"]["localDate"]
        p event["url"]
        line
        space(2)
    end
end 

# title = events_array[0]["name"]
# event_url = events_array[0]["url"]
# event_date = events_array[0]["dates"]["start"]["localDate"]

def search_by_performer
    puts "Who would like to see?"
    performer = get_input
end 


    # $key = pyLDDCYURYJ8LZfAUnOayESRsPBTWnKM
    # response = RestClient.get(url)
    # EVENTBRITE_API_BASE_URL = response_string = RestClient.get('https://app.ticketmaster.com/discovery/v2/events.json?apikey='+ $key + '&city=' + city + '&size=25&localStartDateTime=' + date + 'T00:00:00,' + date + 'T23:59:59')
    # response_hash = JSON.parse(response)

def run
welcome_user
login_or_create_user
present_menu_options
pick_option
end 

