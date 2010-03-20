require 'ftools'
require 'uri'
require 'hpricot'
require 'open4'
require 'scrobbler'
require 'id3lib'

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
    out = File.open(File.join(RAILS_ROOT, 'test.xml')).read
    doc = Hpricot::XML(out)
    (doc/:track).each do |result|
      artist, title = result.at(:artist).innerHTML, result.at(:title).innerHTML
      t = Scrobbler2::Track.new(artist, title)
      p "#{t.info['name']} (#{t.info['mbid']})"
      p "#{t.info['artist']['name']} (#{t.info['artist']['mbid']})" 
      p "#{t.info['album']['name']} (#{t.info['album']['mbid']})"  if t.info['album']
      
    end
  end
  
end

Lastfm.new(1).set_metadata(1)