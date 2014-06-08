require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module Mbb
  class Application < Rails::Application
    config.generators do |g|
      g.view_specs false
      g.helper_specs false
    end

    config.i18n.enforce_available_locales = true
    config.action_mailer.preview_path = "#{Rails.root}/spec/mailers/previews"
  end
end
