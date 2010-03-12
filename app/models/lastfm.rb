require 'ftools'
require 'uri'
require 'hpricot'
require 'open4'
require 'scrobbler'

class Lastfm
  
  def self.smart_scan(dir)
    Dir.entries(dir).each do |entry|
      next if ['.', '..'].include?(entry)
      entry = File.join(dir, entry)
      if File.file?(entry) and File.extname(entry) == '.mp3'
        self.process(entry)
      elsif File.directory?(entry) && entry != '.' && entry != '..'
        Lastfm.recurse(entry)
      end
    end
  end
  
  def self.process(file)
    tmp_dir = File.join RAILS_ROOT, 'tmp', 'lastfm'
    Dir.mkdir(tmp_dir) unless File.exists?(tmp_dir)
    File.copy(file, tmp_dir) 
    Dir.chdir(SETTINGS[:lastfm_dir])
    self.fingerprint( File.join(tmp_dir, File.basename(file)) )
    File.delete( File.join(tmp_dir, File.basename(file)) )
    Dir.chdir(RAILS_ROOT)
  end
  
  def self.fingerprint(file)
    puts '' * 10
    command = "./lastfmfpclient \"#{file}\""
    puts command
    status = Open4.popen4(command) do |pid, stdin, stdout, stderr|
      out, err = stdout.read.strip, stderr.read.chomp 
      Lastfm.set_metadata(out) 
    end
  end
  
  def self.set_metadata(out)
    out = File.open(File.join(RAILS_ROOT, 'test.xml')).read
    doc = Hpricot::XML(out)
    (doc/:track).each do |result|
      artist, title = result.at(:artist).innerHTML, result.at(:title).innerHTML
      t = Scrobbler::Track.new(title, artist)
    end
  end
  
end

Lastfm.smart_scan( File.join(RAILS_ROOT, 'public', 'test_collection'))
  