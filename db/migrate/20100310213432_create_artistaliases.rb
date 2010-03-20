class CreateArtistaliases < ActiveRecord::Migration
  def self.up
    create_table :artistaliases do |t|
      t.integer :artist_id
      t.string :name
      t.integer :time_used
      t.datetime :last_used
      t.integer :modpending, :default => 0

      t.timestamps
    end
    add_index :artistaliases, :name
    add_index :artistaliases, :artist_id
  end

  def self.down
    remove_index :artistaliases, :name
    remove_index :artistaliases, :artist_id
    drop_table :artistaliases
  end
end
