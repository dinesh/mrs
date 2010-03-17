class CreateCollections < ActiveRecord::Migration
  def self.up
    create_table :collections do |t|
      t.integer :user_id, :null => false
      t.string :name, :null => false
      t.datetime :last_update
      t.integer :trackcount, :default => 0
      t.integer :albumcount, :default => 0
      t.integer :artistcount, :default => 0
      t.integer :quality, :default => 0
      t.integer :audio_filecount, :default => 0
      t.integer :setting

      t.timestamps
    end
    
   
  end

  def self.down
    drop_table :collections
  end
end
