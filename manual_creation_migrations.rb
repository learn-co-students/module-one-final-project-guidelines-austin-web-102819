
01_create_users.rb
===================================================================================
class CreateUsers < ActiveRecord::Migration[5.2]

    def change
        create_table :users do |t|
            t.string :name
        end
    end
end


02_create_dictionaries.rb
======================================================================================
class CreateWords < ActiveRecord::Migration[5.2]
    def change
        create_table :words do |t|
            t.string :word
            t.string :definition
            t.string :part_of_speech
        end
    end
end

03_create_wordlist
=================================================
class CreateWordList < ActiveRecord::Migration[5.2]
    def change
        create_table :word_lists do |t|
            t.integer :user_id
            t.integer :word_id
        end
    end
end 