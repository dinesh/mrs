class AudioFile < ActiveRecord::Base
  has_many :collection_audio_files
  has_many :collections, :through => :collection_audio_files
  
  has_attached_file :file, :url  => "/assets/audio_files/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/assets/audio_files/:id/:basename.:extension"

  validates_attachment_presence :file
  validates_attachment_size :file, :less_than => 10.megabytes
  validates_attachment_content_type :file, :content_type => ['audio/mp3']
end

