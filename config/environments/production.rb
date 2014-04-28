Mbb::Application.configure do
  config.cache_classes = true
  config.eager_load = true
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true
  config.serve_static_assets = false
  config.assets.js_compressor = :uglifier
  config.assets.compile = false
  config.assets.digest = true
  config.assets.version = '1.0'
  config.log_level = :info
  config.i18n.fallbacks = true
  config.active_support.deprecation = :notify
  config.log_formatter = ::Logger::Formatter.new

  if ENV['MEMCACHEDCLOUD_SERVERS']
    config.cache_store = :dalli_store, ENV['MEMCACHEDCLOUD_SERVERS'].split(','),
                       {username:ENV['MEMCACHEDCLOUD_USERNAME'],
                       password:ENV['MEMCACHEDCLOUD_PASSWORD']}
  end
end

ActionMailer::Base.smtp_settings = {
    :port =>           '587',
    :address =>        'smtp.mandrillapp.com',
    :user_name =>      ENV['MANDRILL_USERNAME'],
    :password =>       ENV['MANDRILL_APIKEY'],
    :domain =>         'myph.heroku.com',
    :authentication => :plain
}
ActionMailer::Base.delivery_method = :smtp

# elasticsearch-rails
ENV['ELASTICSEARCH_URL'] = ENV['SEARCHBOX_URL']
Elasticsearch::Model.client = Elasticsearch::Client.new log:true, host:'myph.herokuapp.com'