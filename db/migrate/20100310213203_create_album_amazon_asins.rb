class CreateAlbumAmazonAsins < ActiveRecord::Migration
  def self.up
    create_table :album_amazon_asins do |t|
      t.integer :album_id
      t.string :asin
      t.string :coverart_url
      t.datetime :last_update

      t.timestamps
    end
    add_index :album_amazon_asins, :album_id
    add_index :album_amazon_asins, :last_update
  end

  def self.down
    remove_index :album_amazon_asins, :album_id
    remove_index :album_amazon_asins, :last_update
    drop_table :album_amazon_asins
  end
end
