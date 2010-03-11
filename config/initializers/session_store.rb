# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_mrs_session',
  :secret      => '9a11e7e79a6d028d8e9f661d4a1f84e36247004e343671bc90835f4e1e57801fbce46c3778a51abe6c34d712fe038acb9010bbee10465043039ebce78fe4570f'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
