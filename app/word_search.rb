require 'rest-client'
require 'uri'
require 'net/http'
require 'openssl'
require 'pry'
require 'json'
# require 'uri'
# require 'net/http'
# require 'openssl'
# "https://wordsapiv1.p.rapidapi.com/words/curmudgeon"

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
    binding.pry
    puts response.read_body
end

make_request(build_url("hat"))