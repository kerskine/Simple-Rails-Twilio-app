# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_twilio_session',
  :secret      => '12eb64a53d5891fe6ec26d0da8192aff605bf1d807a7a2621f04e4ed68250ad1ec470cce42874b3f8837560532afbd2d4ecfa8e87e00abd8a89d4abf7674273b'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
