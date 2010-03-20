class CreateTracks < ActiveRecord::Migration
  def self.up
    create_table :tracks do |t|
      t.integer :artist_id
      t.string :name
      t.integer :length
      t.integer :year
      t.string :mbid
      t.integer :audio_file_id
      t.timestamps
    end
    add_index :tracks, :artist_id
    add_index :tracks, :name
    add_index :tracks, :mbid
  end

  def self.down
    remove_index :tracks, :artist_id
    remove_index :tracks, :name
    remove_index :tracks, :mbid
    drop_table :tracks
  end
end
