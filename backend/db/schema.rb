# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_08_11_130330) do

  create_table "bookmarks", force: :cascade do |t|
    t.text "content", null: false
    t.integer "video_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.float "time"
    t.integer "playlist_id"
    t.index ["playlist_id"], name: "index_bookmarks_on_playlist_id"
    t.index ["video_id"], name: "index_bookmarks_on_video_id"
  end

  create_table "playlists", force: :cascade do |t|
    t.string "title", null: false
    t.text "description"
    t.string "thumbnail"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "videos", force: :cascade do |t|
    t.string "title", null: false
    t.string "youtube_key", null: false
    t.string "thumbnail"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "embed_url"
    t.datetime "published_at"
  end

  add_foreign_key "bookmarks", "playlists"
  add_foreign_key "bookmarks", "videos"
end
