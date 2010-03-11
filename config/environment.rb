# Be sure to restart your server when you modify this file

# Specifies gem version of Rails to use when vendor/rails is not present
RAILS_GEM_VERSION = '2.3.5' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  config.time_zone = 'UTC'

end

SETTINGS = {
  :genpuid_exe => File.join( RAILS_ROOT, 'vendor', 'genpuid', 'genpuid' ),
  :gen_key => '57aae6071e74345f69143baa210bda87'
}