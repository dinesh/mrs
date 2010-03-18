class Release < ActiveRecord::Base
  belongs_to :album, :class_name => "Album", :foreign_key => "album_id"
  belongs_to :country, :class_name => "Country", :foreign_key => "country_id"
  
end
