class Artist < ActiveRecord::Base
  acts_as_polymorphic_paperclip 
  include MbCache
  validates_uniqueness_of :name, :on => :create, :message => "must be unique"
  @@artist_includes = MusicBrainz::Webservice::ArtistIncludes.new(
    :aliases      => true,
    :releases     => ['Album', 'Official'],
    :artist_rels  => true,
    :release_rels => true,
    :track_rels   => true,
    :label_rels   => true,
    :url_rels     => true
  )
  
  def self.get_instance_by_mbid(url)
    uuid = Artist.model(url).uuid
    artist = Artist.query.get_artist_by_id(uuid, @@artist_includes) 
     p "=== Artist === "
    p "ID            : #{artist.id.uuid}"
    p "Name          : #{artist.name}"
    p "Sort_name     : #{artist.sort_name}"
    p "Disambiguation: #{artist.disambiguation}"
    p "Type          : #{artist.type}"
    p "Begin_date    : #{artist.begin_date}"
    p "End_date      : #{artist.end_date}"
    p "Aliases       : #{artist.aliases.to_a.join('; ')}"
    p "Releases      : #{artist.releases.to_a.join('; ')}"
  
    artist_model  = Artist.find_by_mbid(uuid)
    artist_model = Artist.create({:sortname => artist.sort_name, 
                                  :mbid => artist.id.uuid, 
                                  :name => artist.name }) if artist_model.nil?
    artist_model
  end
  
end
