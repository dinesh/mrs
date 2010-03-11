class CreateAlbumjoins < ActiveRecord::Migration
  def self.up
    create_table :albumjoins do |t|
      t.integer :album_id
      t.integer :track_id
      t.integer :sequence
      t.integer :modpending, :default => 0

      t.timestamps
    end
  end

  def self.down
    drop_table :albumjoins
  end
end
