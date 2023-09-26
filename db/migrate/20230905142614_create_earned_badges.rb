class CreateEarnedBadges < ActiveRecord::Migration[6.1]
  def change
    create_table :earned_badges do |t|
      t.integer :member_id, null: false
      t.integer :badge_id, null: false

      t.timestamps
    end
  end
end
