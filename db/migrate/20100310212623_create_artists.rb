class CreateArtists < ActiveRecord::Migration
  def self.up
    create_table :artists do |t|
      t.string :mbid
      t.string :name
      t.integer :modpending, :default => 0
      t.string :sortname
      t.integer :artist_type

      t.timestamps
    end
  end

  def self.down
    drop_table :artists
  end
end
