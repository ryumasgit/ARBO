class CreateEntryArtists < ActiveRecord::Migration[6.1]
  def change
    create_table :entry_artists do |t|
      t.references :exhibition, null: false, foreign_key: true
      t.references :artist, null: false, foreign_key: true

      t.timestamps
    end
  end
end
