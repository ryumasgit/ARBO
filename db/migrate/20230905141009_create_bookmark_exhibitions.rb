class CreateBookmarkExhibitions < ActiveRecord::Migration[6.1]
  def change
    create_table :bookmark_exhibitions do |t|
      t.references :member, null: false, foreign_key: true
      t.references :exhibition, null: false, foreign_key: true

      t.timestamps
    end
  end
end
