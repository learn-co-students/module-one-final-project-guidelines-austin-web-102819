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
puts "Welcome to the WordBank App!"
puts "==========================="
end
#Username creation

def user_name #This is working on the User model
    puts "Please create a username to create your account:"
    puts "==================================="
    name= gets.chomp
    puts "Your username is: #{name}"
    user_object = User.create(name: name)
    $current_user= user_object
    puts "Thanks for opening an account with WordBank!"
    puts "====================================="
    user_object
end

def search_prompt #this is working on the Word model
    puts "You can now search for any word. Enter your word below and hit 'Enter'"
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
    puts "==============================================="
    puts "#{word}: (#{speech}) #{definition}"
    puts "==============================================="
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
    puts "Do you want to quit or view your WordBank? (quit/wordbank)"
    response=gets.chomp

    if response == "wordbank"
        $current_user.words.each do |word|
            puts "#{word.word}: #{word.definition}"
        end
        # binding.pry
         
    else
        puts "Goodbye! Thanks for using WordBank!"
    end 
end
    # if answer == "y"
    #     word=search_prompt
    #     api_url=build_url(word)
    #     word_array=make_request(api_url)
    #     get_definition($current_user, word_array)



    # else
    #     puts "Goodbye, thanks for using"
    # end



# make_request(build_url("create"))
# get_definition(make_request())

# url= build_url("joke")
# word_array= make_request(url)
# get_definition(word_array)


# This works when we put all the work inside the user_name method.
# This is because the save_word method cannot access the variables in user_name and search_word
# Next steps: Chain the methods together by passing in the first two methods as arguments: save_word(user_name, search_word)