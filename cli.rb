require_relative 'config/environment'

#welcomes the user
def welcome_user
    puts "Welcome to Ticketmaster Lite!"
    puts "==========================="
   space(1)
end 

#ask user if they have an account then login or create one
def login_or_create_user
    puts "Do you have an account with us?
        (y/n)"
    input = get_input
    if input == 'y'
        login_user
    elsif input == 'n'
        create_user
    else 
        invalid_input
        login_or_create_user
    end 
end 

#if user exsit this method logs user in
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

# create_user method is printing unexpected message :
# D, [2019-11-13T10:55:58.329297 #35501] DEBUG -- :    (1.1ms)  SELECT sqlite_version(*)
# D, [2019-11-13T10:55:58.657780 #35501] DEBUG -- :   User Load (0.3ms)  SELECT "users".* FROM "users" WHERE "users"."username" = ? LIMIT ?  [["username", "Jimbo"], ["LIMIT", 1]]"

#If user doesn't exsist create one else log in user
def create_user
    puts "Create a username:"
    username = gets.chomp
    if User.find_by(username: username)
        puts "Sorry, that username is taken! Be more .uniq, playa."
        create_user
        space(1)
    else
    logged_in_user = User.create(username: username)
    puts "Welcome #{username}!"
    $logged_in = logged_in_user.id
    end
end 

#gives user a list of options to choose from
def present_menu_options
    puts "Pick a number. Any number."
    space(2)
    puts '1. search for events by city'
    puts '2. search by keyword'
    puts '3. pick an event for me'
    puts '4. host an event'
    puts '5. view my event calander'
    puts '6. exit'
    space(1)
end 

#depending on the user input from main menu starts option flow
def pick_option
    input = get_input
    if input == '1'
        events_array = search_by_city
        display_events_by_city(events_array)
        
     elsif input == '2'
        attractions_array = search_by_keyword
        display_by_keyword(attractions_array)
    # elsif input == 3
    #     random_event
    # elsif input == 4
    #     create_event
    # elsif input == 5
    #     user.event_planner
    # elsif input == 6
    #     puts "Thank you!"
    else
        invalid_input
        pick_option
    end 
end 

#takes user input and searches; returns an array
def search_by_city
    puts "Where would you like to look?"
    city = get_input
    url = "https://app.ticketmaster.com/discovery/v2/events?apikey=pyLDDCYURYJ8LZfAUnOayESRsPBTWnKM&locale=*&city="+ city
    response = RestClient.get(url)
    events = JSON.parse(response)["_embedded"]["events"]
    events_array = events[0...19]
    events_array
end

#takes user input and searches; returns an array
def search_by_keyword
    puts "What do you want to search for?"
    keyword = get_input
    url = "https://app.ticketmaster.com/discovery/v2/attractions?apikey=pyLDDCYURYJ8LZfAUnOayESRsPBTWnKM&keyword="+ keyword +"&locale=*"
    response = RestClient.get(url)
    attractions = JSON.parse(response)["_embedded"]["attractions"]
    attractions[0...19]
end

# attractions[0]['name']
# attractions[0]['url']

#takes the return of search_by method option 1 and displays them in a readable manner
def display_events_by_city(events_array)
    events_array.each_with_index do |event, index|
        puts index.to_s + '.' 
        line
        puts event["name"]
        puts event["dates"]["start"]["localDate"]
        puts event["url"]
        line
        space(2)
    end
end 

# takes the return of search_by method option 2 and displays them in a readable manner
def display_by_keyword(attractions_array)
    
    attractions_array.each do |attractions|
        line
        p attractions["name"]
        p attractions["url"]
        line
        space(2)
    end
end

#====================================================================================================================
#====================================================================================================================
#THE BIG CHULUPA 
def run
welcome_user
login_or_create_user
present_menu_options

pick_option
end
#====================================================================================================================
#====================================================================================================================

#helper methods
def get_input
    gets.chomp
end

#message helper methods
def invalid_input
    puts "Please enter a valid response"
end

#visual helper methods
def space(num)
    num.times do
        puts
    end 
end 

def line
    puts "----------------------------"
end 

def double_line
    puts '============================'
end

### NOTES
# $key = pyLDDCYURYJ8LZfAUnOayESRsPBTWnKM
# response = RestClient.get(url)
# EVENTBRITE_API_BASE_URL = response_string = RestClient.get('https://app.ticketmaster.com/discovery/v2/events.json?apikey='+ $key + '&city=' + city + '&size=25&localStartDateTime=' + date + 'T00:00:00,' + date + 'T23:59:59')
# response_hash = JSON.parse(response)

# title = events_array[0]["name"]
# event_url = events_array[0]["url"]
# event_date = events_array[0]["dates"]["start"]["localDate"]


# def get_events_for_artist_and_city(artist, city)
#     response_string = RestClient.get('https://app.ticketmaster.com/discovery/v2/events.json?apikey='+ $key + '&city=' + city + '&size=25&keyword=' + artist )
#     response_hash = JSON.parse(response_string)
#     convert_json_data_to_ruby_objects(response_hash)
#     display_output_with_date
#     event = retrieve_user_selection
#     event_info(event)
# end

