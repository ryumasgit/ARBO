class CreateMuseums < ActiveRecord::Migration[6.1]
  def change
    create_table :museums do |t|
      t.string :museum_name, null: false, unique: true
      t.string :introduction, null: false
      t.string :official_website, null: false
      t.boolean :is_active, null: false, default: true

      t.timestamps
    end
  end
end
