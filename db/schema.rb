# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2023_09_05_142614) do

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "admin_name", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "artists", force: :cascade do |t|
    t.string "artist_name", null: false
    t.string "introduction", null: false
    t.boolean "is_active", default: true, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "badges", force: :cascade do |t|
    t.string "badge_name", null: false
    t.string "introduction", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "bookmark_exhibitions", force: :cascade do |t|
    t.integer "member_id", null: false
    t.integer "exhibition_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["exhibition_id"], name: "index_bookmark_exhibitions_on_exhibition_id"
    t.index ["member_id"], name: "index_bookmark_exhibitions_on_member_id"
  end

  create_table "bookmark_museums", force: :cascade do |t|
    t.integer "member_id", null: false
    t.integer "museum_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["member_id"], name: "index_bookmark_museums_on_member_id"
    t.index ["museum_id"], name: "index_bookmark_museums_on_museum_id"
  end

  create_table "earned_badges", force: :cascade do |t|
    t.integer "report_id", null: false
    t.integer "badge_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["badge_id"], name: "index_earned_badges_on_badge_id"
    t.index ["report_id"], name: "index_earned_badges_on_report_id"
  end

  create_table "entry_artists", force: :cascade do |t|
    t.integer "exhibition_id", null: false
    t.integer "artist_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["artist_id"], name: "index_entry_artists_on_artist_id"
    t.index ["exhibition_id"], name: "index_entry_artists_on_exhibition_id"
  end

  create_table "exhibitions", force: :cascade do |t|
    t.integer "museum_id", null: false
    t.string "exhibition_name", null: false
    t.string "introduction", null: false
    t.string "official_website", null: false
    t.boolean "is_active", default: true, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["museum_id"], name: "index_exhibitions_on_museum_id"
  end

  create_table "favorites", force: :cascade do |t|
    t.integer "member_id", null: false
    t.integer "review_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["member_id"], name: "index_favorites_on_member_id"
    t.index ["review_id"], name: "index_favorites_on_review_id"
  end

  create_table "member_tags", force: :cascade do |t|
    t.integer "member_id", null: false
    t.integer "tag_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["member_id"], name: "index_member_tags_on_member_id"
    t.index ["tag_id"], name: "index_member_tags_on_tag_id"
  end

  create_table "members", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "member_name", null: false
    t.string "introduction"
    t.boolean "is_active", default: true, null: false
    t.boolean "is_guest", default: false, null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_members_on_email", unique: true
    t.index ["reset_password_token"], name: "index_members_on_reset_password_token", unique: true
  end

  create_table "museums", force: :cascade do |t|
    t.string "museum_name", null: false
    t.string "introduction", null: false
    t.string "official_website", null: false
    t.boolean "is_active", default: true, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "relationships", force: :cascade do |t|
    t.integer "follower_id", null: false
    t.integer "followed_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["followed_id"], name: "index_relationships_on_followed_id"
    t.index ["follower_id"], name: "index_relationships_on_follower_id"
  end

  create_table "reports", force: :cascade do |t|
    t.integer "member_id", null: false
    t.integer "total_favorited", default: 0, null: false
    t.integer "museum_visits", default: 0, null: false
    t.integer "exhibition_visits", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["member_id"], name: "index_reports_on_member_id"
  end

  create_table "review_comments", force: :cascade do |t|
    t.integer "member_id", null: false
    t.integer "review_id", null: false
    t.string "comment", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["member_id"], name: "index_review_comments_on_member_id"
    t.index ["review_id"], name: "index_review_comments_on_review_id"
  end

  create_table "review_tags", force: :cascade do |t|
    t.integer "review_id", null: false
    t.integer "tag_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["review_id"], name: "index_review_tags_on_review_id"
    t.index ["tag_id"], name: "index_review_tags_on_tag_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.integer "member_id", null: false
    t.integer "exhibition_id", null: false
    t.string "title", null: false
    t.string "body"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["exhibition_id"], name: "index_reviews_on_exhibition_id"
    t.index ["member_id"], name: "index_reviews_on_member_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "tag_name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "bookmark_exhibitions", "exhibitions"
  add_foreign_key "bookmark_exhibitions", "members"
  add_foreign_key "bookmark_museums", "members"
  add_foreign_key "bookmark_museums", "museums"
  add_foreign_key "earned_badges", "badges"
  add_foreign_key "earned_badges", "reports"
  add_foreign_key "entry_artists", "artists"
  add_foreign_key "entry_artists", "exhibitions"
  add_foreign_key "exhibitions", "museums"
  add_foreign_key "favorites", "members"
  add_foreign_key "favorites", "reviews"
  add_foreign_key "member_tags", "members"
  add_foreign_key "member_tags", "tags"
  add_foreign_key "relationships", "members", column: "followed_id"
  add_foreign_key "relationships", "members", column: "follower_id"
  add_foreign_key "reports", "members"
  add_foreign_key "review_comments", "members"
  add_foreign_key "review_comments", "reviews"
  add_foreign_key "review_tags", "reviews"
  add_foreign_key "review_tags", "tags"
  add_foreign_key "reviews", "exhibitions"
  add_foreign_key "reviews", "members"
end
