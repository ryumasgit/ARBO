class CreateReviewComments < ActiveRecord::Migration[6.1]
  def change
    create_table :review_comments do |t|
      t.integer :member_id, null: false
      t.integer :review_id, null: false
      t.string :comment, null: false

      t.timestamps
    end
    
    add_index :review_comments, :member_id
    add_index :review_comments, :review_id
  end
end
