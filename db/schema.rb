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

ActiveRecord::Schema.define(version: 20201130021459) do

  create_table "cardgames", force: :cascade do |t|
    t.integer "game_id"
    t.string  "user_ids"
    t.string  "deck_ids"
    t.string  "discard_ids"
    t.string  "hand_ids"
    t.boolean "started"
    t.integer "hand_size"
  end

  create_table "decks", force: :cascade do |t|
    t.integer "deck_id"
    t.string  "cards"
  end

  create_table "hands", force: :cascade do |t|
    t.integer "hand_id"
    t.integer "user_id"
    t.string  "cards"
  end

  create_table "users", force: :cascade do |t|
    t.integer "user_id"
    t.string  "username"
    t.string  "password"
    t.string  "session_token"
    t.integer "current_game"
    t.string  "email"
  end

end
