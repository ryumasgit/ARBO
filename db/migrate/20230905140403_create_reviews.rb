class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|
      t.references :member, null: false, foreign_key: true
      t.references :exhibition, null: false, foreign_key: true
      t.string :title, null: false
      t.string :introdution

      t.timestamps
    end
  end
end
