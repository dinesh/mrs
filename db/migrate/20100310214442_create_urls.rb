class CreateUrls < ActiveRecord::Migration
  def self.up
    create_table :urls do |t|
      t.integer :mbid
      t.string :url
      t.text :description
      t.integer :refcount, :default => 0 
      t.integer :modpending, :default => 0 

      t.timestamps
    end
  end

  def self.down
    drop_table :urls
  end
end
