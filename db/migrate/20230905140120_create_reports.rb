class CreateReports < ActiveRecord::Migration[6.1]
  def change
    create_table :reports do |t|
      t.integer :member_id, null: false
      t.integer :total_favorited, null: false, default: 0
      t.integer :museum_visits, null: false, default: 0
      t.integer :exhibition_visits, null: false, default: 0

      t.timestamps
    end
  end
end
