class CreateExhibitions < ActiveRecord::Migration[6.1]
  def change
    create_table :exhibitions do |t|
      t.integer :museum_id, null: false
      t.string :name, null: false
      t.string :introduction, null: false
      t.string :official_website, null: false
      t.boolean :is_active, null: false, default: true

      t.timestamps
    end
    
    add_index :exhibitions, :museum_id
  end
end
