
class Lastfm
  attr_accessor :num_tracks, :num_albums, :num_artists, :num_audio_files
  attr_accessor :collection, :file_chunk
  
  def initialize(c)
    @num_tracks, @num_albums, @num_artists, @num_audio_files = 0,0,0,0 
    @collection = c
    @file_chunk = []
  end
  
  def smart_scan(dir)
    recurse(dir)
  end
  
  def recurse(dir)
    Dir.entries(dir).each do |entry|
      next if ['.', '..'].include?(entry)
      entry = File.join(dir, entry)
      if File.file?(entry) and File.extname(entry) == '.mp3'
        process(entry)
      elsif File.directory?(entry) && entry != '.' && entry != '..'
        recurse(entry)
      end
    end
  end
  
  def process(file)
    Dir.chdir(SETTINGS[:lastfm_dir])
    fingerprint(file)
    Dir.chdir(RAILS_ROOT)
  end
  
  def fingerprint(file)
    puts '==' * 10
    tag = ID3Lib::Tag.new(file)
    puts "#{tag.title} #{tag.album} #{tag.length}"
    command = "./lastfmfpclient \"#{file}\""
    puts command
    status = Open4.popen4(command) do |pid, stdin, stdout, stderr|
      out, err = stdout.read.strip, stderr.read.chomp 
      set_metadata(out) 
    end
  end
  
  def set_metadata(out)
    #out = File.open(File.join(RAILS_ROOT, 'test.xml')).read
    doc = Hpricot::XML(out)
    puts "\n" * 3
    result = (doc/:track).first
    return if result.nil?
   # (doc/:track).to_a.first do |result|
      artist, title = result.at(:artist).innerHTML, result.at(:title).innerHTML
      t = Scrobbler2::Track.new(artist, title)
      artist, album = t.info['artist'], t.info['album']
      return if (t.info.nil? || t.info['name'] || artist.nil? || album.nil?)
      
      p "Title         : #{t.info['name']}: (#{t.info['mbid']})" 
      p "Artist        : #{t.info['artist']['name']} (#{t.info['artist']['mbid']})"  
      p "Album:        : #{t.info['album']['name']} (#{t.info['album']['mbid']})"  
      
      audio_file = AudioFile.find_by_file_file_name(File.basename(file))
      audio_file = AudioFile.create(:file => File.open(file)) if audio_file.nil? 
      artist_model = Artist.find(:first, :conditions => {:name => artist['name'], :mbid => artist[:mbid] })
      artist_model = artist_model.nil? ? Artist.create({:name => artist['name'], :mbid => artist[:mbid]}) : artist_model
      
      album_model = Album.find(:first, :conditions => {:name => album['name'], :mbid => album[:mbid] })
      album_model = album_model.nil? ? Album.create({:artist => artist_model, :name => album['name'], 
                                                      :mbid => album[:mbid]}) : album_model
                                                      
      track_model = Track.find(:first, :conditions => {:name => t.info['name'], :artist => artist_model})
      track_model = track_model.nil? ? Track.create({:name => t.info['name'], :artist => artist_model, 
                                                      :audio_file => audio_file}) : track_model
    # end
  end
  
end


