class CreateMemberTags < ActiveRecord::Migration[6.1]
  def change
    create_table :member_tags do |t|
      t.integer :member_id, null: false
      t.integer :tag_id, null: false

      t.timestamps
    end
  end
end
