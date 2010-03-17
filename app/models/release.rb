class Release < ActiveRecord::Base
  belongs_to :album, :class_name => "Album", :foreign_key => "album_id"
  belongs_to :album, :class_name => "Album", :foreign_key => "album_id"
  validates_uniqueness_of :title, :on => :create, :message => "must be unique"
  include MbCache
  
  @@release_include = MusicBrainz::Webservice::ReleaseIncludes.new(
      :artist => true, :counts => true, :release_events => true,
      :tracks => true, :labels => true, :tags => true,
      :artist_rels  => true,
      :release_rels => true,
      :track_rels   => true,
      :label_rels   => true,
      :url_rels     => true
  )
  

  
end
