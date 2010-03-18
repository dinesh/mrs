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
  end

  def self.down
    drop_table :tracks
  end
end
