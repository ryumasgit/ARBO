class CreateBookmarkExhibitions < ActiveRecord::Migration[6.1]
  def change
    create_table :bookmark_exhibitions do |t|
      t.integer :member_id, null: false
      t.integer :exhibition_id, null: false

      t.timestamps
    end
  end
end
