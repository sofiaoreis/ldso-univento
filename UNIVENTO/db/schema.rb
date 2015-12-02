# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 0) do

  create_table "Category", primary_key: "categoryID", force: :cascade do |t|
    t.string "name", limit: 50
  end

  create_table "CategoryTags", id: false, force: :cascade do |t|
    t.integer "tagsID",     limit: 4
    t.integer "categoryID", limit: 4
  end

  add_index "CategoryTags", ["categoryID"], name: "categoryID", using: :btree
  add_index "CategoryTags", ["tagsID"], name: "tagsID", using: :btree

  create_table "Colaborator", id: false, force: :cascade do |t|
    t.integer "promoterID", limit: 4
    t.integer "normalID",   limit: 4
  end

  add_index "Colaborator", ["normalID"], name: "normalID", using: :btree
  add_index "Colaborator", ["promoterID"], name: "promoterID", using: :btree

  create_table "Event", primary_key: "eventID", force: :cascade do |t|
    t.text    "descrition",  limit: 65535
    t.string  "name",        limit: 50
    t.boolean "propose"
    t.float   "averageRate", limit: 53
    t.integer "numRates",    limit: 4
    t.boolean "active"
    t.string  "docsID",      limit: 255
    t.integer "categoryID",  limit: 4
    t.integer "promoterID",  limit: 4
    t.float   "preco",       limit: 53
  end

  add_index "Event", ["categoryID"], name: "categoryID", using: :btree
  add_index "Event", ["promoterID"], name: "promoterID", using: :btree

  create_table "EventDate", primary_key: "dateID", force: :cascade do |t|
    t.datetime "startDate"
    t.float    "preco",     limit: 53
    t.datetime "endDate"
    t.integer  "eventID",   limit: 4
    t.integer  "localID",   limit: 4
  end

  add_index "EventDate", ["eventID"], name: "eventID", using: :btree
  add_index "EventDate", ["localID"], name: "localID", using: :btree

  create_table "EventTags", id: false, force: :cascade do |t|
    t.integer "eventID", limit: 4
    t.integer "tagsID",  limit: 4
  end

  add_index "EventTags", ["eventID"], name: "eventID", using: :btree
  add_index "EventTags", ["tagsID"], name: "tagsID", using: :btree

  create_table "Image", primary_key: "imageID", force: :cascade do |t|
    t.string  "image",   limit: 255
    t.integer "eventID", limit: 4
  end

  add_index "Image", ["eventID"], name: "eventID", using: :btree

  create_table "Local", primary_key: "localID", force: :cascade do |t|
    t.string  "address",   limit: 50
    t.integer "latitude",  limit: 4
    t.integer "longitude", limit: 4
  end

  create_table "Normal", primary_key: "normalID", force: :cascade do |t|
    t.date   "birthday"
    t.string "first_name", limit: 50
    t.string "gender",     limit: 50
    t.string "last_name",  limit: 50
  end

  create_table "Promoter", primary_key: "promoterID", force: :cascade do |t|
    t.string "contact",     limit: 50
    t.string "institution", limit: 50
    t.string "name",        limit: 50
    t.string "website",     limit: 50
  end

  create_table "Rate", primary_key: "rateID", force: :cascade do |t|
    t.integer "rate",     limit: 4
    t.integer "eventID",  limit: 4
    t.integer "normalID", limit: 4
  end

  add_index "Rate", ["eventID"], name: "eventID", using: :btree
  add_index "Rate", ["normalID"], name: "normalID", using: :btree

  create_table "Registration", id: false, force: :cascade do |t|
    t.integer "eventID",  limit: 4
    t.integer "normalID", limit: 4
  end

  add_index "Registration", ["eventID"], name: "eventID", using: :btree
  add_index "Registration", ["normalID"], name: "normalID", using: :btree

  create_table "Spotify", primary_key: "spotifyID", force: :cascade do |t|
    t.string  "playListLink", limit: 50
    t.integer "eventID",      limit: 4
  end

  add_index "Spotify", ["eventID"], name: "eventID", using: :btree

  create_table "Tags", primary_key: "tagsID", force: :cascade do |t|
    t.string "name", limit: 50
  end

  create_table "User", primary_key: "userID", force: :cascade do |t|
    t.string   "password",               limit: 255
    t.boolean  "admin"
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.string   "provider",               limit: 255
    t.string   "uid",                    limit: 255
  end

  add_index "User", ["email"], name: "index_User_on_email", unique: true, using: :btree
  add_index "User", ["provider"], name: "index_User_on_provider", using: :btree
  add_index "User", ["reset_password_token"], name: "index_User_on_reset_password_token", unique: true, using: :btree
  add_index "User", ["uid"], name: "index_User_on_uid", using: :btree

  create_table "Youtube", primary_key: "youtubeID", force: :cascade do |t|
    t.string  "videoID", limit: 50
    t.integer "eventID", limit: 4
  end

  add_index "Youtube", ["eventID"], name: "eventID", using: :btree

  add_foreign_key "CategoryTags", "Category", column: "categoryID", primary_key: "categoryID", name: "FK_CategoryTags_Category", on_delete: :cascade
  add_foreign_key "CategoryTags", "Tags", column: "tagsID", primary_key: "tagsID", name: "FK_CategoryTags_Tags", on_delete: :cascade
  add_foreign_key "Colaborator", "Normal", column: "normalID", primary_key: "normalID", name: "FK_Colaborator_Normal", on_delete: :cascade
  add_foreign_key "Colaborator", "Promoter", column: "promoterID", primary_key: "promoterID", name: "FK_Colaborator_Promoter", on_delete: :cascade
  add_foreign_key "Event", "Category", column: "categoryID", primary_key: "categoryID", name: "FK_Event_Category", on_delete: :cascade
  add_foreign_key "Event", "Promoter", column: "promoterID", primary_key: "promoterID", name: "FK_Event_Promoter", on_delete: :cascade
  add_foreign_key "EventDate", "Event", column: "eventID", primary_key: "eventID", name: "FK_Date_Event", on_delete: :cascade
  add_foreign_key "EventDate", "Local", column: "localID", primary_key: "localID", name: "FK_Date_Local", on_delete: :cascade
  add_foreign_key "EventTags", "Event", column: "eventID", primary_key: "eventID", name: "FK_EventTags_Event", on_delete: :cascade
  add_foreign_key "EventTags", "Tags", column: "tagsID", primary_key: "tagsID", name: "FK_EventTags_Tags", on_delete: :cascade
  add_foreign_key "Image", "Event", column: "eventID", primary_key: "eventID", name: "FK_Image_Event", on_delete: :cascade
  add_foreign_key "Normal", "User", column: "normalID", primary_key: "userID", name: "FK_Normal_User", on_delete: :cascade
  add_foreign_key "Promoter", "User", column: "promoterID", primary_key: "userID", name: "FK_Promoter_User", on_delete: :cascade
  add_foreign_key "Rate", "Event", column: "eventID", primary_key: "eventID", name: "FK_Rate_Event", on_delete: :cascade
  add_foreign_key "Rate", "Normal", column: "normalID", primary_key: "normalID", name: "FK_Rate_Normal", on_delete: :cascade
  add_foreign_key "Registration", "Event", column: "eventID", primary_key: "eventID", name: "FK_Registration_Event", on_delete: :cascade
  add_foreign_key "Registration", "Normal", column: "normalID", primary_key: "normalID", name: "FK_Registration_Normal", on_delete: :cascade
  add_foreign_key "Spotify", "Event", column: "eventID", primary_key: "eventID", name: "FK_Spotify_Event", on_delete: :cascade
  add_foreign_key "Youtube", "Event", column: "eventID", primary_key: "eventID", name: "FK_Youtube_Event", on_delete: :cascade
end
