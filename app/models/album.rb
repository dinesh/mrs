class Album < ActiveRecord::Base
  acts_as_polymorphic_paperclip 
  belongs_to :artist, :class_name => "Artist", :foreign_key => "artist_id"
  
  @@small_release_include = MusicBrainz::Webservice::ReleaseIncludes.new(
    :tracks => true, 
    :release_events => true, :artist => true
  )
  
  def self.get_instance_by_mbid(uuid, artist_item)
    release = Release.query.get_release_by_id(uuid, @@small_release_include)
    
    p "ID            : #{release.id.uuid}"
    p "Title         : #{release.title}"
    p "Asin          : #{release.asin}"
    p "Artist        : #{release.artist.name}"
    p "Release Events: #{release.release_events.inject([]){ |l,r| l << [r.country , r.date, r.label, r.barcode]}.inspect}"
    p "Tracks        : #{release.tracks.to_a.join('; ')}"
    
    album_model = Album.find_by_mbid uuid
    album_model = Album.create({:artist => artist_item, :name => release.title,  
                                  :mbid => uuid }) if album_model.nil?
    album_model
  end
  
end
