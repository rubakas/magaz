# Be sure to restart your server when you modify this file.

Magaz::Application.config.session_store ActionDispatch::Session::CacheStore, 
  key: '_magaz_session',
  # domain: ".#{HOSTNAME}"
  domain: :all