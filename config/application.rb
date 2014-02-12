require File.expand_path('../boot', __FILE__)

# Pick the frameworks you want:
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module VinkedIt
  class Application < Rails::Application
    config.action_mailer.delivery_method = :smtp
    ActionMailer::Base.smtp_settings = {
        :port           => '25',
        :address        => ENV['POSTMARK_SMTP_SERVER'],
        :user_name      => ENV['POSTMARK_API_KEY'],
        :password       => ENV['POSTMARK_API_KEY'],
        :domain         => 'backbone-app.heroku.com',
        :authentication => :plain,
    }

    # don't generate RSpec tests for views and helpers
    config.generators do |g|

      g.test_framework :rspec, fixture: true
      g.fixture_replacement :factory_girl, dir: 'spec/factories'


      g.view_specs false
      g.helper_specs false
    end

    config.i18n.default_locale = :en
    config.i18n.enforce_available_locales = false
    config.assets.initialize_on_precompile = false
    config.assets.paths << Rails.root.join("app", "assets", "fonts")
  end
end
