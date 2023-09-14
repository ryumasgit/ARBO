class CreateBookmarkMuseums < ActiveRecord::Migration[6.1]
  def change
    create_table :bookmark_museums do |t|
      t.references :member, null: false, foreign_key: true
      t.references :museum, null: false, foreign_key: true

      t.timestamps
    end
  end
end
