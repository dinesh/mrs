class CollectionAudioFile < ActiveRecord::Base
  belongs_to :audio_file, :class_name => "AudioFile", :foreign_key => "audio_file_id"
  belongs_to :collection, :class_name => "Collection", :foreign_key => "collection_id"
end
