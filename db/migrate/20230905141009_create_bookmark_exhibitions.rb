class CreateBookmarkExhibitions < ActiveRecord::Migration[6.1]
  def change
    create_table :bookmark_exhibitions do |t|
      t.integer :member_id, null: false
      t.integer :exhibition_id, null: false

      t.timestamps
    end
    
    add_index :bookmark_exhibitions, :member_id
    add_index :bookmark_exhibitions, :exhibition_id
  end
end
