class CreateQuestions < ActiveRecord::Migration[5.1]
    def change
        create_table :questions do |t|
            t.string :question
        end
    end
end