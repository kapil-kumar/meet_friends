OmniAuth.config.logger = Rails.logger
OmniAuth.config.full_host = 'http://localhost:3000'
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, FACEBOOK_APP_ID, FACEBOOK_APP_SECRET, :secure_image_url => true
  provider :google_oauth2, GOOGLE_APP_ID, GOOGLE_APP_SECRET, {client_options: {ssl: {ca_file: Rails.root.join("cacert.pem").to_s}}}
end