class CreatePuids < ActiveRecord::Migration
  def self.up
    create_table :puids do |t|
      t.string :puid
      t.integer :lookupcount, :default => 0
      t.timestamps
    end
    add_index :puids, :puid
  end

  def self.down
    remove_index :puids, :puid
    drop_table :puids
  end
end
