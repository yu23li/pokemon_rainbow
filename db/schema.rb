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

ActiveRecord::Schema.define(version: 2018_10_19_085709) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "pokedexes", force: :cascade do |t|
    t.string "name", limit: 45, null: false
    t.integer "base_health_point", null: false
    t.integer "base_attack", null: false
    t.integer "base_defence", null: false
    t.integer "base_speed", null: false
    t.string "element_type", limit: 225
    t.string "image_url", limit: 225, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_pokedexes_on_name", unique: true
  end

  create_table "pokemon_battles", force: :cascade do |t|
    t.integer "pokemon1_id", null: false
    t.integer "pokemon2_id", null: false
    t.integer "current_turn"
    t.string "state"
    t.integer "pokemon_winner_id"
    t.integer "pokemon_loser_id"
    t.integer "experience_gain"
    t.integer "pokemon1_max_health_point"
    t.integer "pokemon2_max_health_point"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pokemon_skills", force: :cascade do |t|
    t.integer "skill_id"
    t.integer "pokemon_id"
    t.integer "current_pp"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pokemons", force: :cascade do |t|
    t.integer "pokedex_id"
    t.string "name", limit: 45, null: false
    t.integer "level"
    t.integer "max_health_point"
    t.integer "current_health_point"
    t.integer "attack"
    t.integer "defence"
    t.integer "speed"
    t.integer "current_experience"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_pokemons_on_name", unique: true
  end

  create_table "skills", force: :cascade do |t|
    t.string "name", limit: 45, null: false
    t.integer "power", null: false
    t.integer "max_pp"
    t.string "element_type", limit: 45
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "pokemon_battles", "pokemons", column: "pokemon1_id"
  add_foreign_key "pokemon_battles", "pokemons", column: "pokemon2_id"
  add_foreign_key "pokemon_battles", "pokemons", column: "pokemon_loser_id"
  add_foreign_key "pokemon_battles", "pokemons", column: "pokemon_winner_id"
  add_foreign_key "pokemon_skills", "pokemons"
  add_foreign_key "pokemon_skills", "skills"
  add_foreign_key "pokemons", "pokedexes"
end
