class CreateTrackpuids < ActiveRecord::Migration
  def self.up
    create_table :trackpuids do |t|
      t.integer :puid_id
      t.integer :track_id
      t.integer :use_count, :default => 0 

      t.timestamps
    end
  end

  def self.down
    drop_table :trackpuids
  end
end
