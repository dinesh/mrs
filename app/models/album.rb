class Album < ActiveRecord::Base
  acts_as_polymorphic_paperclip 
  has_many :releases
  belongs_to :artist, :class_name => "Artist", :foreign_key => "artist_id"
  include MbCache
  validates_uniqueness_of :mbid, :on => :create, :message => "must be unique"
  @@small_release_include = MusicBrainz::Webservice::ReleaseIncludes.new(
    :tracks => true, 
    :release_events => true, :artist => true
  )
  
  def self.get_instance_by_mbid(uuid, artist_item)
    release = Album.query.get_release_by_id(uuid, @@small_release_include)
    p "=== Album === "
    p "ID            : #{release.id.uuid}"
    p "Title         : #{release.title}"
    p "Asin          : #{release.asin}"
    p "Artist        : #{release.artist.name}"
    p "Release Events: #{release.release_events.inject([]){ |l,r| l << [r.country , r.date, r.label, r.barcode]}.inspect}"
    p "Tracks        : #{release.tracks.to_a.join('; ')}"
    
    album_model = Album.find_by_mbid uuid
    album_model = Album.create({:artist => artist_item, :name => release.title.to_s,  
                                :mbid => release.id.uuid }) if album_model.nil?
    album_model.save  
    album_model.release_events = release.release_events.to_a  
    album_model
  end
  
  def release_events=(rels)
    rels.each do  |rel| 
      date = rel.date.to_s
      old_rel = Release.find(:first,:conditions => {:album_id => self.id, :release_date => date, :barcode => rel.barcode})
      country = Country.find_by_isocode(rel.country.to_s)
      Release.create(:release_date => date, 
          :country => country, :album => self,
          :barcode => rel.barcode) if old_rel.nil? && rel.date
    end
  end
  
end
