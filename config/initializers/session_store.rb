# Be sure to restart your server when you modify this file.

Magaz::Application.config.session_store :cookie_store,
  { :key => Rails.root.split[1].to_s + '_session' },
  # domain: ".#{HOSTNAME}"
  domain: :all