class CreateAudioFiles < ActiveRecord::Migration
  def self.up
    create_table :audio_files do |t|
      t.string :http_url
      t.string :ftp_url
      t.text :lan_settings
      t.string :status
      t.integer :quality, :default => 0

      t.timestamps
    end
  end

  def self.down
    drop_table :audio_files
  end
end
