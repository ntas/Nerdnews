# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_nerdnews_session',
  :secret      => '21d7b43632c0d4317124fdd6e8e8b8a8c302367c5304c94c9e07abe0a69fb0168758f1a4e72e29024ee9a752c2828482615ebb9d1c53c2eed2b2f1467f919566'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
