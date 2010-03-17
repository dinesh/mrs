
module MbCache
  
  def self.included(base)
    base.extend ClassMethods
  end
  
  module ClassMethods
    
    def mbservice
      @@mbservice ||= MusicBrainz::Webservice::Webservice.new(:proxy => ENV['http_proxy'])
    end
    
    def query
      @@query ||= MusicBrainz::Webservice::Query.new(self.mbservice)
    end
    
    def model(url)
      MusicBrainz::Model::MBID.new(url)
    end
  end
  
  module InstanceMethods
    
  end
  
end