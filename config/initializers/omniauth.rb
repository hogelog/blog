Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2,
    ENV["GOOGLE_KEY"],
    ENV["GOOGLE_SECRET"],
    path_prefix: '/admin'
end
