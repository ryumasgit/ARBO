class CreateReviewComments < ActiveRecord::Migration[6.1]
  def change
    create_table :review_comments do |t|
      t.references :member, null: false, foreign_key: true
      t.references :review, null: false, foreign_key: true
      t.string :comment, null: false

      t.timestamps
    end
  end
end
