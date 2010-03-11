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
  end

  def self.down
    drop_table :artistaliases
  end
end
