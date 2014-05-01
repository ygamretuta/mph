ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'capybara/rails'
require 'capybara/rspec'
require 'capybara/poltergeist'

# coveralls service
require 'coveralls'
Coveralls.wear!('rails')

include ActionDispatch::TestProcess
Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }
ActiveRecord::Migration.check_pending! if defined?(ActiveRecord::Migration)

include Warden::Test::Helpers
Warden.test_mode!

Capybara.javascript_driver = :poltergeist

FactoryGirl.define do
  after(:create) {|obj| obj.class.reindex if obj.class.respond_to?(:reindex) }
end

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = false
  config.infer_base_class_for_anonymous_controllers = false
  config.mock_with :rspec
  config.order = "random"
  
  # https://github.com/plataformatec/devise/wiki/How-To:-Controllers-tests-with-Rails-3-(and-rspec)
  config.include Devise::TestHelpers, :type => :controller
  config.extend  ControllerMacros, :type => :controller

  config.filter_run_excluding broken:true

  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each, es: true) do
    if Item.searchkick_index.exists?
      Item.searchkick_index.delete
      Item.reindex
    end
  end


  config.before(:each, js:true) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end