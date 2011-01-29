require 'rubygems'
require 'spork'

Spork.prefork do
  ENV["RAILS_ENV"] ||= 'test'
  require File.expand_path("../../config/environment", __FILE__)
  require 'rspec/rails'

  Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

  RSpec.configure do |config|
    config.mock_with :rspec
    config.use_transactional_fixtures = true

    config.include Stubs, :type => :view, :example_group => {
      :file_path => config.escaped_path(%w[spec (views|helpers)])
    }

    config.include MySpec::IntegrationHelper, :type => :integration, :example_group => {
      :file_path => config.escaped_path(%w[spec integration])
    }
  end
end

Spork.each_run do
  require 'factory_girl_rails'
end
