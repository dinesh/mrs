
namespace :finger do
  
  desc "Scan a directory"
  task :scan, [:dir] => :environment do |t, args|
      recurse args.dir if File.directory?(args.dir) 
  end
  
  
  def recurse(dir)
    puts '' * 10
    puts "----------- Scanning #{dir} ------------------"
    Dir.entries(dir).each do |entry|
      next if ['.', '..'].include?(entry)
      entry = File.join(dir, entry)
      if File.file?(entry) and File.extname(entry) == '.mp3'
          genpuid(entry)
          lastfm(entry)
      elsif File.directory?(entry) && entry != '.' && entry != '..'
        recurse(entry)
      end
    end
  end
  
  def genpuid(track)
    puts File.basename(track)
      command = "#{SETTINGS[:genpuid_exe]} #{SETTINGS[:gen_key]} #{track} -proxy #{ENV['http_proxy']}"
      puts command
      #out = system(command)
      
  end
  
  def lastfm(track)
    
  end
  
end
