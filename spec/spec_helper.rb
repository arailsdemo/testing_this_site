require 'rubygems'
require 'spork'

Spork.prefork do
  ENV["RAILS_ENV"] ||= 'test'
  require File.expand_path("../../config/environment", __FILE__)
  require 'rspec/rails'

  Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

  RSpec.configure do |config|
    config.mock_with :rspec
    config.use_transactional_fixtures = false

    config.include Stubs, :type => :view, :example_group => {
      :file_path => config.escaped_path(%w[spec (views|helpers)])
    }

    config.include MySpec::IntegrationHelper, :type => :integration, :example_group => {
      :file_path => config.escaped_path(%w[spec (integration|requests)])
    }
  end

  RSpec.configure do |config|
    config.before(:suite) do
      DatabaseCleaner.strategy = :transaction
      DatabaseCleaner.clean_with :truncation
    end

    config.before(:each) do
      if example.metadata[:js]
        Capybara.current_driver = :selenium
        DatabaseCleaner.strategy = :truncation
      else
        DatabaseCleaner.strategy = :transaction
        DatabaseCleaner.start
      end
    end

    config.after(:each) do
      Capybara.use_default_driver if example.metadata[:js]
      DatabaseCleaner.clean
    end
  end

  RSpec.configure do |config|
    config.filter_run_excluding :js => true
  end

   module RSpec
    module Core
      class World
        attr_accessor :hack_run_all

        def inclusion_filter
          if @configuration && @configuration.filter && @configuration.filter.has_key?(:all)
            @configuration.filter = nil
            self.hack_run_all = true
          end
          @configuration.filter
        end

        def exclusion_filter
          @configuration.exclusion_filter.delete(:js) if self.hack_run_all || (@configuration.filter && @configuration.filter.has_key?(:js))
          @configuration.exclusion_filter
        end
      end
    end
  end
end

Spork.each_run do
  require 'factory_girl_rails'
end
