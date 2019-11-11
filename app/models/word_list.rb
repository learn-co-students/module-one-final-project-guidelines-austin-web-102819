class WordList < ActiveRecord::Base
    belongs_to :user # this describes the foreign keys of user
    belongs_to :word #this describes the foreign keys of words
end