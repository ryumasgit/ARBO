class CreateEarnedBadges < ActiveRecord::Migration[6.1]
  def change
    create_table :earned_badges do |t|
      t.references :report, null: false, foreign_key: true
      t.references :badge, null: false, foreign_key: true

      t.timestamps
    end
  end
end
