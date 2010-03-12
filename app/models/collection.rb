class Collection < ActiveRecord::Base
  belongs_to :user, :class_name => "User", :foreign_key => "user_id"
  has_many :collection_audio_files
  has_many :audio_files, :through => :collection_audio_files
  
end
