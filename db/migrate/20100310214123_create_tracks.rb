class CreateTracks < ActiveRecord::Migration
  def self.up
    create_table :tracks do |t|
      t.integer :artist_id
      t.string :name
      t.integer :length
      t.integer :year
      t.integer :mbid

      t.timestamps
    end
  end

  def self.down
    drop_table :tracks
  end
end
