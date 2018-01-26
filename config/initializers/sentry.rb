# Sentry Config
Raven.configure do |config|
  config.dsn = 'https://3a12ac8d624841e59a2cdf9a8fea5e6a:7fd12b6ecc834b1bb9d169a7c78af0e3@sentry.io/277100'
  config.environments = ['production']
  config.sanitize_fields = Rails.application.config.filter_parameters.map(&:to_s)
  
  if Rails.env.development?
    config.silence_ready = true
  end
end
