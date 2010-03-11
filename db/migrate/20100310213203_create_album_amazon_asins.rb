class CreateAlbumAmazonAsins < ActiveRecord::Migration
  def self.up
    create_table :album_amazon_asins do |t|
      t.integer :album_id
      t.string :asin
      t.string :coverart_url
      t.datetime :last_update

      t.timestamps
    end
  end

  def self.down
    drop_table :album_amazon_asins
  end
end
