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

ActiveRecord::Schema[8.1].define(version: 2026_09_01_021233) do
  create_table "books", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "dealers", force: :cascade do |t|
    t.string "DealerName"
    t.decimal "HouseEarning"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "deals", force: :cascade do |t|
    t.datetime "DealAt"
    t.integer "DealerHandValue"
    t.integer "GameID"
    t.integer "RoundNumber"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "game_entries", force: :cascade do |t|
    t.string "GameID"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "games", force: :cascade do |t|
    t.decimal "BetMinimum"
    t.integer "DealersID"
    t.string "GameName"
    t.boolean "InPlay"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "player_hands", force: :cascade do |t|
    t.decimal "Bet"
    t.integer "DealID"
    t.integer "EntryID"
    t.string "Outcome"
    t.string "Payout"
    t.integer "PlayerHandValue"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "players", force: :cascade do |t|
    t.string "PlayName"
    t.decimal "TotalEarnings"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end
end
