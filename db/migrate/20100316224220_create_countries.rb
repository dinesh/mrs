class CreateCountries < ActiveRecord::Migration
  def self.up
    create_table :countries do |t|
      t.string :isocode
      t.string :name_caps
      t.string :name
      t.string :iso3code
      t.integer :num_code
      t.timestamps
    end
  end

  def self.down
    drop_table :countries
  end
end
