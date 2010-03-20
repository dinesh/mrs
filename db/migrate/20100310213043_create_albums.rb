class CreateAlbums < ActiveRecord::Migration
  def self.up
    create_table :albums do |t|
      t.string :mbid
      t.integer :artist_id
      t.string :name
      t.integer :status
      t.integer :script
      t.integer :language
      t.integer :quality

      t.timestamps
    end
    add_index :albums, :name
    add_index :albums, :artist_id
  end

  def self.down
    remove_index :album_amazon_asins, :album_id
    remove_index :album_amazon_asins, :last_update
    drop_table :albums
  end
end
