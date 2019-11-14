require 'pry'
require 'rest-client'
require 'uri'
require 'net/http'
require 'openssl'
require 'pry'
require 'json'
$current_user=nil
# Output welcome message
def welcome
puts "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n"

puts "██╗    ██╗ ██████╗ ██████╗ ██████╗ ██████╗  █████╗ ███╗   ██╗██╗  ██╗
██║    ██║██╔═══██╗██╔══██╗██╔══██╗██╔══██╗██╔══██╗████╗  ██║██║ ██╔╝
██║ █╗ ██║██║   ██║██████╔╝██║  ██║██████╔╝███████║██╔██╗ ██║█████╔╝ 
██║███╗██║██║   ██║██╔══██╗██║  ██║██╔══██╗██╔══██║██║╚██╗██║██╔═██╗ 
╚███╔███╔╝╚██████╔╝██║  ██║██████╔╝██████╔╝██║  ██║██║ ╚████║██║  ██╗
 ╚══╝╚══╝  ╚═════╝ ╚═╝  ╚═╝╚═════╝ ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═══╝╚═╝  ╚═╝ "
                                                                                   
puts "============================================================================== \n
                           Welcome to the WordBank App!" 
puts "\n=============================================================================="
puts "******************************************************************************"
puts "=============================================================================="
end
#Username creation

def user_name #This is working on the User model
    puts "\n               Please create a username to create your account: \n\n"
    puts "=============================================================================="
    name= gets.chomp
    puts "=============================================================================="
    puts "Your username is: #{name}"
    user_object = User.create(name: name)
    $current_user= user_object
    puts "******************************************************************************"
    puts "Thanks for opening an account with WordBank!"
    puts "******************************************************************************"
    user_object
end

def search_prompt #this is working on the Word model
    puts "You can now search for any word. Type your word below and hit 'Enter'"
    word = gets.chomp

end

WORDS_API_URL= "https://wordsapiv1.p.rapidapi.com/words/"

def build_url(word_object)
    url = "#{WORDS_API_URL}#{word_object}"
    url
end

def make_request(builtUrl)
    url = URI(builtUrl)

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Get.new(url)
    request["x-rapidapi-host"] = 'wordsapiv1.p.rapidapi.com'
    request["x-rapidapi-key"] = '2df3014c24mshd2b068316cb08b8p13a365jsn553cbf262f9d'

    response = http.request(request)
    parsed_response = JSON(response.read_body)
end

def get_definition(user_object, word_array)
    word= word_array["word"]
    definition= word_array["results"][0]["definition"]
    speech= word_array["results"][0]["partOfSpeech"]
    puts "==============================================================================\n"
    puts "\n*** #{word}: (#{speech}) #{definition} *** \n"
    puts "\n==============================================================================\n"
    create_word= Word.create(word: word, definition: definition, part_of_speech: speech)
    new_word_list_item= WordList.create(user_id: user_object.id, word_id: create_word.id)
end

def search_again
    puts "Do you want to search for another word? (y/n)"
    answer= gets.chomp

    while answer == "y" do
        word=search_prompt
        api_url=build_url(word)
        word_array=make_request(api_url)
        get_definition($current_user, word_array)
        search_again
    end
        list_or_quit
end

def list_or_quit
    puts "==============================================================================\n"
    puts "Do you want to quit or view your WordBank? (quit/wordbank)"
    response=gets.chomp

    if response == "quit" 
        quit_program
        # binding.pry
    else
    puts "=============================================================================="
    puts "$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$"
    puts "==============================================================================\n"
    puts "          __   __   __   __                    
    |  | /  \\ |__) |  \\ |__)  /\\  |\\ | |__/    
    |/\\| \\__/ |  \\ |__/ |__) /~~\\ | \\| |  \\    
                                               "
     
    $current_user.words.each do |word|
        puts "               #{word.word}: #{word.definition} \n"
        end
        puts "\n=============================================================================="
        puts "$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$"
        puts "=============================================================================="
    end
end
  
def quit_program
    puts "=============================================================================="
    puts "
    ██████╗  ██████╗  ██████╗ ██████╗ ██████╗ ██╗   ██╗███████╗██╗
   ██╔════╝ ██╔═══██╗██╔═══██╗██╔══██╗██╔══██╗╚██╗ ██╔╝██╔════╝██║
   ██║  ███╗██║   ██║██║   ██║██║  ██║██████╔╝ ╚████╔╝ █████╗  ██║
   ██║   ██║██║   ██║██║   ██║██║  ██║██╔══██╗  ╚██╔╝  ██╔══╝  ╚═╝
   ╚██████╔╝╚██████╔╝╚██████╔╝██████╔╝██████╔╝   ██║   ███████╗██╗
    ╚═════╝  ╚═════╝  ╚═════╝ ╚═════╝ ╚═════╝    ╚═╝   ╚══════╝╚═╝
                                                                  
   "
    puts "Goodbye! Thanks for using WordBank!"
    puts "=============================================================================="
    exit
end