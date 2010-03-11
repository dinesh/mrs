require 'ftools'
require 'uri'
require 'hpricot'
require 'rbrainz'
require 'open4'

class Genpuid
 
  @@file_chunk = []
  
  def self.scan(dir)
  end
  
  def self.smart_scan(dir)
    Genpuid.recurse(dir)
  end
  
  def self.recurse(dir)
    Dir.entries(dir).each do |entry|
      next if ['.', '..'].include?(entry)
      entry = File.join(dir, entry)
      if File.file?(entry) and File.extname(entry) == '.mp3'
        @@file_chunk.push(entry) 
        self.process(@@file_chunk) if @@file_chunk.size >= 13
      elsif File.directory?(entry) && entry != '.' && entry != '..'
        Genpuid.recurse(entry)
      end
    end
    Genpuid.process(@@file_chunk) if @@file_chunk.size > 1
  end
  
  def self.process(files)
    tmp_dir = File.join RAILS_ROOT, 'tmp', 'genpuid'
    Dir.mkdir(tmp_dir) unless File.exists?(tmp_dir)
    files.each {|file| File.copy(file, tmp_dir) }
    self.fingerprint(tmp_dir)
    files.each {|file| File.delete( File.join(tmp_dir, File.basename(file))) }
    @@file_chunk = []
  end
  
  def self.fingerprint(dir)
    puts '' * 10
    proxy = URI.parse ENV['http_proxy']
    command = "#{SETTINGS[:genpuid_exe]} #{SETTINGS[:gen_key]} -m3lib=music.m3lib -proxy #{proxy.host} -xml  -r #{dir}"
    puts command
    status = Open4.popen4(command) do |pid, stdin, stdout, stderr|
      out = stdout.read.strip
     # puts out
      gindex = out.index('<genpuid')-1
      if gindex > 0
        out.slice!(0..gindex)
        xml_output = Hpricot::XML(out)
        (xml_output/:track).each do |track|
          file, puid, status = track.attributes['file'], track.attributes['puid'], track.attributes['status']
            Genpuid.set_metadata(file, puid, status) if puid
        end
      end
    end
  end
  
  def self.set_metadata(file, puid, status)
    service = MusicBrainz::Webservice::Webservice.new(:proxy => ENV['http_proxy'])
    q = MusicBrainz::Webservice::Query.new(service)
    q.get_tracks(:puid => puid).each do |result|
      puts '' * 20
      t = result.entity.id 
      a = result.entity.artist.id
      r = result.entity.releases.entries.collect(&:id).first
      p q.get_artist_by_id(a).name
      p q.get_release_by_id(r).title
      p q.get_track_by_id(t).title
    end
    
    
  end
end

Genpuid.smart_scan( File.join(RAILS_ROOT, 'public', 'test_collection'))
