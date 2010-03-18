class Trackpuid < ActiveRecord::Base
  belongs_to :track, :class_name => "Track", :foreign_key => "track_id"
  belongs_to :puid, :class_name => "Puid", :foreign_key => "puid_id"
end
