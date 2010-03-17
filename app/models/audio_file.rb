class AudioFile < ActiveRecord::Base
  has_many :collection_audio_files
  has_many :collections, :through => :collection_audio_files
  has_many :tracks
  
  
  has_attached_file :file, :url  => "/assets/audio_files/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/collection/:id/:basename.:extension"
  
  validates_presence_of :file, :on => :create, :message => "can't be blank"
  validates_attachment_size :file, :less_than => 10.megabytes
  validates_attachment_content_type :file, :content_type => [ 'application/mp3', 'application/x-mp3', 'audio/mpeg', 'audio/mp3' ],
                                            :message => 'must be of filetype .mp3'
  
  def set_mime_type(data)
    data.content_type = MIME::Types.type_for(data.original_filename).to_s
    self.file = data 
  end
  
  
  
end

