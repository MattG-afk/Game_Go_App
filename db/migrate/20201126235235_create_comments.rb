class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.integer :stars
      t.string :content
      t.integer :user_id
      t.integer :game_id

      t.timestamps
    end
  end
end
