class CreateArtists < ActiveRecord::Migration
  def self.up
    create_table :artists do |t|
      t.string :mbid
      t.string :name
      t.integer :modpending, :default => 0
      t.string :sortname
      t.integer :artist_type
      t.date :begin_date
      t.date :end_date
      t.timestamps
    end
    add_index :artists, :name
    add_index :artists, :sortname
  end

  def self.down
    remove_index :artists, :name
    remove_index :artists, :sortname
    drop_table :artists
  end
end
