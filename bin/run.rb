require_relative '../config/environment.rb'

welcome
user_object= user_name
word= search_prompt
api_url=build_url(word)
word_array=make_request(api_url)
get_definition(user_object, word_array)
search_again


