class CreateBadges < ActiveRecord::Migration[6.1]
  def change
    create_table :badges do |t|
      t.string :name, null: false, unique: true
      t.string :introduction, null: false
      t.boolean :is_active, null: false, default: true

      t.timestamps
    end
  end
end
