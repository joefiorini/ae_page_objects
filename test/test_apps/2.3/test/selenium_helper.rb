ENV['RAILS_ENV'] = 'test'

$LOAD_PATH << File.join(File.dirname(__FILE__), '..')

require "config/environment"

# Run the migrations
ActiveRecord::Migrator.migrate("#{Rails.root}/db/migrate")

require "test_help"

require 'capybara/dsl'
require 'capybara/rails'

Dir["../../test_helpers/**/*.rb"].each {|f| require f}

module Selenium
  class TestCase < ActiveSupport::TestCase
    include Capybara::DSL
    include AfCruft

    self.use_instantiated_fixtures  = false
    self.use_transactional_fixtures = false

    fixtures :all

    include ActionController::UrlWriter
    ActionController::Routing::Routes.install_helpers(self)

    teardown do
      AePageObjects::Browser.instance.windows.close_all
    end
  end
end

Capybara.configure do |config|
  config.default_driver    = :selenium
  config.ignore_hidden_elements = false
  config.default_wait_time = 5
end

require "test/page_objects"

