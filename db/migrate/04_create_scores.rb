class CreateScores < ActiveRecord::Migration[5.1]
    def change
        create_table :scores do |t|
            t.integer :score
            t.integer :user_id
        end
    end
end