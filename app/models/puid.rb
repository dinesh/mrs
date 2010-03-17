class Puid < ActiveRecord::Base
 has_many :track_puids
 has_many :tracks, :through => :track_puids
 
 def self.find_or_create_by_puid(puid)
    puid_model = Puid.find_by_puid(puid)
    puid_model.update_attributes({:lookupcount => puid_model.lookupcount + 1}) if puid_model
    puid_model = Puid.create(:puid => puid) if puid_model
    puid_model
 end
 
end
