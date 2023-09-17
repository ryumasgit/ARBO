class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|
      t.bigint :member_id, null: false
      t.references :exhibition, null: false, foreign_key: true
      t.string :body, null: false

      t.timestamps
    end
  end
end
