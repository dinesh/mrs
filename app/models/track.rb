class Track < ActiveRecord::Base
  acts_as_polymorphic_paperclip 
  belongs_to :artist
  has_many :trackpuids
  has_many :puids, :through => :trackpuids
  include MbCache
  
  @@track_includes = MusicBrainz::Webservice::TrackIncludes.new(:puids => true, :releases => true)
  
  def self.get_instance_by_mbid(url,artist_item, puid)
      uuid = Track.model(url).uuid
      t = Track.query.get_track_by_id(uuid, @@track_includes)
       p "=== Track === "
        p "ID            : #{t.id.uuid}"
        p "Name          : #{t.title}"
        p "Releases      : #{t.releases.map(&:title).join('; ')}"
        p "Duration      : #{t.duration}"
        p "Artist        : #{t.artist}"
        p "Puids         : #{t.puids.to_a.join('; ')}"
        
        artist = Artist.find_by_name(t.artist)
        track_model = Track.find_by_mbid(uuid) 
        track_model = Track.create({:artist => artist_item, :name => t.title, 
                                    :length => t.duration, :mbid => uuid }) if track_model.nil?
        puid_model = Puid.find_or_create_by_puid(puid)
        track_model.puids << puid_model unless track_model.puids.include?(puid_model)                            
        track_model
  end
  
end
