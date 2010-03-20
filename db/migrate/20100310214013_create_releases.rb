class CreateReleases < ActiveRecord::Migration
  def self.up
    create_table :releases do |t|
      t.integer :album_id
      t.integer :country_id
      t.date :release_date
      t.string :catno
      t.string :barcode
      t.string :format
      t.integer :release_type

      t.timestamps
    end
    add_index :releases, :album_id
    add_index :releases, :barcode
  end

  def self.down
    remove_index :releases, :album_id
    remove_index :releases, :barcode
    drop_table :releases
  end
end
