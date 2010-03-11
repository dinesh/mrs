class CreateIsrcs < ActiveRecord::Migration
  def self.up
    create_table :isrcs do |t|
      t.integer :track_id
      t.string :isrc
      t.integer :source
      t.integer :modpending

      t.timestamps
    end
  end

  def self.down
    drop_table :isrcs
  end
end
