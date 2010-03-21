# Be sure to restart your server when you modify this file

# Specifies gem version of Rails to use when vendor/rails is not present
RAILS_GEM_VERSION = '2.3.5' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  config.time_zone = 'UTC'
  config.gem 'paperclip'
  config.gem 'authlogic'
end

SETTINGS = {
  :gen_key => '57aae6071e74345f69143baa210bda87',
  :lastfm_exe => File.join(RAILS_ROOT, 'vendor', 'lastfm', 'lastfmfpclient'), 
  :lastfm_dir => File.join(RAILS_ROOT, 'vendor', 'lastfm')
}

require 'ftools'
require 'uri'
require 'hpricot'
require 'rbrainz'
require 'open4'
require 'id3lib'
require 'scrobbler2'

Scrobbler2::Base.api_key = "b25b959554ed76058ac220b7b2e0a026"
