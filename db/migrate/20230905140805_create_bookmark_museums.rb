class CreateBookmarkMuseums < ActiveRecord::Migration[6.1]
  def change
    create_table :bookmark_museums do |t|
      t.integer :member_id, null: false
      t.integer :museum_id, null: false

      t.timestamps
    end
    
    add_index :bookmark_museums, :member_id
    add_index :bookmark_museums, :museum_id
  end
end
