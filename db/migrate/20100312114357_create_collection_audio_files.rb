class CreateCollectionAudioFiles < ActiveRecord::Migration
  def self.up
    create_table :collection_audio_files do |t|
      t.integer :collection_id, :null => false
      t.integer :audio_file_ids, :null => false
      t.string :status, :default => 'pending'
      t.integer :lookupcount, :default => 0

      t.timestamps
    end
  end

  def self.down
    drop_table :collection_audio_files
  end
end
