class CreateReports < ActiveRecord::Migration[6.1]
  def change
    create_table :reports do |t|
      t.references :member, null: false, foreign_key: true
      t.integer :total_favorited, null: false, default: 0
      t.integer :museum_visits, null: false, default: 0
      t.integer :exhibition_visits, null: false, default: 0

      t.timestamps
    end
  end
end
