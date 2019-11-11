class Word < ActiveRecord::Base
    has_many :word_lists
    has_many :users, through: :word_lists
end