class CreateWordLists < ActiveRecord::Migration[6.0]
  def change
    create_table :word_lists do |t|
      t.integer :user_id
      t.integer :word_id
  end
  end
end
