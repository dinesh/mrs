class CreateReleases < ActiveRecord::Migration
  def self.up
    create_table :releases do |t|
      t.integer :album_id
      t.integer :country_id
      t.datetime :release_date
      t.string :catno
      t.string :barcode
      t.string :format
      t.integer :release_type

      t.timestamps
    end
  end

  def self.down
    drop_table :releases
  end
end
