# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_live_session',
  :secret      => 'ce59b408e4d1475b19bf257f9b2380fd2e94a4522f9f85fe5b9a4ff8afe32e36bf5c8af47ffcfec995fa63dc7ee216002b45c7414f35744142a782428a7451d4'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
