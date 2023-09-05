class CreateExhibitions < ActiveRecord::Migration[6.1]
  def change
    create_table :exhibitions do |t|
      t.references :museum, null: false, foreign_key: true
      t.string :exhibition_name, null: false
      t.string :introdution, null: false
      t.string :official_website, null: false
      t.boolean :is_active, null: false, default: true

      t.timestamps
    end
  end
end
