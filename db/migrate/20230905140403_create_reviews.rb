class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|
      t.references :member, type: :bigint, null: false, foreign_key: true
      t.references :exhibition, type: :bigint, null: false, foreign_key: true
      t.string :body, null: false

      t.timestamps
    end
  end
end
