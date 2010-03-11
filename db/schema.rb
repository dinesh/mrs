# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100310214442) do

  create_table "album_amazon_asins", :force => true do |t|
    t.integer  "album_id"
    t.string   "asin"
    t.string   "coverart_url"
    t.datetime "last_update"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "albumjoins", :force => true do |t|
    t.integer  "album_id"
    t.integer  "track_id"
    t.integer  "sequence"
    t.integer  "modpending", :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "albums", :force => true do |t|
    t.integer  "mbid"
    t.integer  "artist_id"
    t.string   "name"
    t.integer  "status"
    t.integer  "script"
    t.integer  "language"
    t.integer  "quality"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "artistaliases", :force => true do |t|
    t.integer  "artist_id"
    t.string   "name"
    t.integer  "time_used"
    t.datetime "last_used"
    t.integer  "modpending", :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "artists", :force => true do |t|
    t.string   "mbid"
    t.string   "name"
    t.integer  "modpending",  :default => 0
    t.string   "sortname"
    t.integer  "artist_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "isrcs", :force => true do |t|
    t.integer  "track_id"
    t.string   "isrc"
    t.integer  "source"
    t.integer  "modpending"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "puids", :force => true do |t|
    t.string   "puid"
    t.integer  "lookupcount", :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "releases", :force => true do |t|
    t.integer  "album_id"
    t.integer  "country_id"
    t.datetime "release_date"
    t.string   "catno"
    t.string   "barcode"
    t.string   "format"
    t.integer  "release_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "trackpuids", :force => true do |t|
    t.integer  "puid_id"
    t.integer  "track_id"
    t.integer  "use_count",  :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tracks", :force => true do |t|
    t.integer  "artist_id"
    t.string   "name"
    t.integer  "length"
    t.integer  "year"
    t.integer  "mbid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "urls", :force => true do |t|
    t.integer  "mbid"
    t.string   "url"
    t.text     "description"
    t.integer  "refcount",    :default => 0
    t.integer  "modpending",  :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
