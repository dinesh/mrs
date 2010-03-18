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
  end

  def self.down
    drop_table :albums
  end
end
