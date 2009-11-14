# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_nerd_session',
  :secret      => 'e7f7c30d66b9a08186d5d5ac4a6b594dbc83ddda4750a144ad6a9e809fcde0e830e11ce82c797edc05d4407f94170dff7592267a8f357b9d2be2505b5f439629'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
