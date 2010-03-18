class Genpuid
 
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
  
  def mservice
    @mservice ||= MusicBrainz::Webservice::Webservice.new(:proxy => ENV['http_proxy'])
  end
  
  def query
    @query ||=  MusicBrainz::Webservice::Query.new(mservice)
  end
  
  def recurse(dir)
    Dir.entries(dir).each do |entry|
      next if ['.', '..'].include?(entry)
      entry = File.join(dir, entry)
      if File.file?(entry) and File.extname(entry) == '.mp3'
        @file_chunk.push(entry) 
        process(@file_chunk) if @file_chunk.size >= 20
      elsif File.directory?(entry) && entry != '.' && entry != '..'
        recurse(entry)
      end
    end
    process(@file_chunk) if @file_chunk.size > 1
  end
  
  def process(files)
    tmp_dir = File.join RAILS_ROOT, 'tmp', 'genpuid'
    Dir.mkdir(tmp_dir) unless File.exists?(tmp_dir)
    files.each {|file| File.copy(file, tmp_dir) }
    fingerprint(tmp_dir)
    files.each {|file| File.delete( File.join(tmp_dir, File.basename(file))) }
    @file_chunk = []
  end
  
  def fingerprint(dir)
    puts '' * 10
    proxy = URI.parse ENV['http_proxy']
    command = "#{SETTINGS[:genpuid_exe]} #{SETTINGS[:gen_key]} -m3lib=music.m3lib -proxy #{proxy.host} -xml  -r #{dir}"
    puts command
    status = Open4.popen4(command) do |pid, stdin, stdout, stderr|
      out = stdout.read.strip
      gindex = out.index('<genpuid')-1
      if gindex > 0
        out.slice!(0..gindex)
        xml_output = Hpricot::XML(out)
        (xml_output/:track).each do |track|
          file, puid, status = track.attributes['file'], track.attributes['puid'], track.attributes['status']
            set_metadata(file, puid, status) if puid
        end
      end
    end
  end
  
  def set_metadata(file, puid, status)
    return unless Puid.find_by_puid(puid).nil?
    query.get_tracks(:puid => puid).each do |result|
      puts "\n" * 3
      puts "----- #{file} -------- "
      track = result.entity
  #    audio_file = AudioFile.find_by_file_file_name(File.basename(file))
  #    audio_file = AudioFile.create(:file => File.open(track.attributes[:file])) if audio_file.nil? 
      artist = Artist.get_instance_by_mbid(track.artist.id)
      track.releases.each{ |release| Album.get_instance_by_mbid(release.id, artist) }
      t = Track.get_instance_by_mbid(track.id, artist, puid)
      
    end
  end
end
