class CreateTrackpuids < ActiveRecord::Migration
  def self.up
    create_table :trackpuids do |t|
      t.integer :puid_id
      t.integer :track_id
      t.integer :use_count, :default => 0 

      t.timestamps
    end
    add_index :trackpuids, :puid_id
    add_index :trackpuids, :track_id
  end

  def self.down
    remove_index :trackpuids, :puid_id
    remove_index :trackpuids, :track_id
    drop_table :trackpuids
  end
end
