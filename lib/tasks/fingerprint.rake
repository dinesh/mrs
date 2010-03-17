
namespace :finger do
  
  desc "Scan a directory"
  task :add, [:dir] => :environment do |t, args|
      c = collection = User.get_collection_for_admin
      c.reload
      p "Adding to collection: #{collection.name}"
      if collection
        genpuid = Genpuid.new(c)
        genpuid.smart_scan(args.dir)
        collection.update_attributes({:trackcount => genpuid.num_tracks, :artistcount => genpuid.num_artists, 
                          :albumcount => genpuid.num_albums, :audio_filecount => genpuid.num_audio_files })
        collection.destroy if collection.stat_empty?
      end
  end
  
  
end
