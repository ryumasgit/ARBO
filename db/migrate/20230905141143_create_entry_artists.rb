class CreateEntryArtists < ActiveRecord::Migration[6.1]
  def change
    create_table :entry_artists do |t|
      t.integer :exhibition_id, null: false
      t.integer :artist_id, null: false

      t.timestamps
    end
    
    add_index :entry_artists, :exhibition_id
    add_index :entry_artists, :artist_id
  end
end
