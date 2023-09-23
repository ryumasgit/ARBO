class CreateFavorites < ActiveRecord::Migration[6.1]
  def change
    create_table :favorites do |t|
      t.integer :member_id, null: false
      t.integer :review_id, null: false

      t.timestamps
    end

    add_index :favorites, :member_id
    add_index :favorites, :review_id
  end
end
