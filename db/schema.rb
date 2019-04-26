# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_04_26_091854) do

  create_table "agreements", force: :cascade do |t|
    t.text "content"
    t.boolean "is_accepted"
    t.boolean "is_agree"
    t.integer "avatar_id"
    t.integer "discussion_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["avatar_id"], name: "index_agreements_on_avatar_id"
    t.index ["discussion_id"], name: "index_agreements_on_discussion_id"
  end

  create_table "arguments", force: :cascade do |t|
    t.integer "num"
    t.text "content"
    t.datetime "publish_time"
    t.integer "discussion_id"
    t.integer "avatar_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["avatar_id"], name: "index_arguments_on_avatar_id"
    t.index ["discussion_id"], name: "index_arguments_on_discussion_id"
  end

  create_table "avatars", force: :cascade do |t|
    t.string "name"
    t.text "opinion"
    t.integer "discussion_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["discussion_id"], name: "index_avatars_on_discussion_id"
    t.index ["user_id"], name: "index_avatars_on_user_id"
  end

  create_table "criteria", force: :cascade do |t|
    t.string "text"
    t.integer "discussion_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["discussion_id"], name: "index_criteria_on_discussion_id"
  end

  create_table "discussions", force: :cascade do |t|
    t.string "topic_title"
    t.string "topic_description"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "arguments_count"
    t.boolean "private"
    t.integer "forked_from"
    t.index ["user_id"], name: "index_discussions_on_user_id"
  end

  create_table "general_comments", force: :cascade do |t|
    t.string "text"
    t.integer "user_id"
    t.integer "discussion_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["discussion_id"], name: "index_general_comments_on_discussion_id"
    t.index ["user_id"], name: "index_general_comments_on_user_id"
  end

  create_table "participants", force: :cascade do |t|
    t.integer "discussion_id"
    t.integer "user_id"
    t.string "token"
    t.boolean "verified"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["discussion_id"], name: "index_participants_on_discussion_id"
    t.index ["user_id"], name: "index_participants_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "full_name"
    t.string "email"
    t.string "uid"
    t.string "provider"
    t.string "session_token"
    t.datetime "session_token_expires_at"
    t.string "image_url"
  end

end
