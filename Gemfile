source 'https://rubygems.org'
source 'https://rails-assets.org'

# gems bundled with Rails 4
gem 'rails'
gem 'sass-rails', '~> 4.0.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 1.2'

# 3rd-party gems
gem 'simple_form'
gem 'devise'
gem 'enumerize'
gem 'carrierwave'
gem 'cloudinary'
gem 'draper'
gem 'mini_magick'
gem 'nested_form'
gem 'whenever', require:false
gem 'faker'
gem 'squeel'
gem 'kaminari'
gem 'rails_admin'
gem 'cancan'
gem 'merit'
gem 'thin'
gem 'sidekiq'
gem 'rolify'

# rails integration of existing libraries
gem 'haml-rails'
gem 'foundation-rails'
gem 'jquery-ui-rails'
gem 'pg'
gem 'poltergeist'
gem 'mandrill-api'
gem 'omniauth-facebook'

# rails assets
gem 'rails-assets-blueimp-file-upload'
gem 'rails-assets-angular'

# public services
gem 'coveralls', require:false


group :doc do
  gem 'sdoc', require: false
end

group :development do
  gem 'html2haml'
  gem 'capistrano'
  gem 'quiet_assets'
  gem 'brakeman'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'guard-livereload'
  gem 'rack-livereload'
  gem 'meta_request'
  gem 'letter_opener'
end

group :development, :test do
  gem 'debugger'
  gem 'rspec', '~> 3.0.0.beta2'
  gem 'rspec-rails', '~> 3.0.0.beta'
  gem 'factory_girl_rails'
  gem 'rb-fsevent', require:false
  gem 'capybara', github:'jnicklas/capybara'
  gem 'guard-annotate', require:false
  gem 'guard-brakeman', require:false
  gem 'guard-rspec', '~> 4.2.7', require:false
  gem 'dotenv-rails'
end

group :test do
  gem 'turn', require:false
  gem 'shoulda'
  gem 'shoulda-matchers'
  gem 'database_cleaner'
end

group :production do
  gem 'rails_12factor'
  gem 'dalli'
end
