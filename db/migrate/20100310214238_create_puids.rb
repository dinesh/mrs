class CreatePuids < ActiveRecord::Migration
  def self.up
    create_table :puids do |t|
      t.string :puid
      t.integer :lookupcount, :default => 0

      t.timestamps
    end
  end

  def self.down
    drop_table :puids
  end
end
