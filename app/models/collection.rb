class Collection < ActiveRecord::Base
  belongs_to :user, :class_name => "User", :foreign_key => "user_id"
  has_many :collection_audio_files
  has_many :audio_files, :through => :collection_audio_files
  
  validates_uniqueness_of :name, :on => :create, :message => "must be unique"
  
  def stat_empty?
    stat = self.trackcount || self.albumcount || self.artistcount || self.audio_filecount
    stat.equal?(0) ? true : false
  end
  
end
