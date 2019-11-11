class User < ActiveRecord::Base # How our model knows to use Active Record\
    has_many :word_lists # need to put this first, bc active record will error out
    has_many :words, through: :word_lists  #this tells active record to find the data through the join table word_lists
end