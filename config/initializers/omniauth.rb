twitter_config = YAML::load(File.read("config/twitter.yml"))[Rails.env]
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer unless Rails.env.production?
  provider :twitter, twitter_config['consumer_key'], twitter_config['consumer_secret']
end