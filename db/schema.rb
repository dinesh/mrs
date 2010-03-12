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

ActiveRecord::Schema.define(:version => 20100312190532) do

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

  create_table "assets", :force => true do |t|
    t.string   "data_file_name"
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "attachings_count",  :default => 0
    t.datetime "created_at"
    t.datetime "data_updated_at"
  end

  create_table "attachings", :force => true do |t|
    t.integer  "attachable_id"
    t.integer  "asset_id"
    t.string   "attachable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "attachings", ["asset_id"], :name => "index_attachings_on_asset_id"
  add_index "attachings", ["attachable_id"], :name => "index_attachings_on_attachable_id"

  create_table "audio_files", :force => true do |t|
    t.string   "http_url"
    t.string   "ftp_url"
    t.text     "lan_settings"
    t.string   "status"
    t.integer  "quality",           :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
  end

  create_table "collection_audio_files", :force => true do |t|
    t.integer  "collection_id",                         :null => false
    t.integer  "audio_file_ids",                        :null => false
    t.string   "status",         :default => "pending"
    t.integer  "lookupcount",    :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "collections", :force => true do |t|
    t.integer  "user_id",                        :null => false
    t.datetime "last_update"
    t.integer  "trackcount",      :default => 0
    t.integer  "albumcount",      :default => 0
    t.integer  "artistcount",     :default => 0
    t.integer  "quality",         :default => 0
    t.integer  "audio_filecount", :default => 0
    t.integer  "setting"
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

  create_table "users", :force => true do |t|
    t.string   "login",               :default => "", :null => false
    t.string   "email",               :default => "", :null => false
    t.string   "crypted_password",    :default => "", :null => false
    t.string   "password_salt",       :default => "", :null => false
    t.string   "persistence_token",   :default => "", :null => false
    t.string   "single_access_token", :default => "", :null => false
    t.string   "perishable_token",    :default => "", :null => false
    t.integer  "login_count",         :default => 0,  :null => false
    t.integer  "failed_login_count",  :default => 0,  :null => false
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string   "current_login_ip"
    t.string   "last_login_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
