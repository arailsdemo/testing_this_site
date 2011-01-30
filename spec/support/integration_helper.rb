module MySpec
  module IntegrationHelper
    def self.included(base)
      base.class_eval do
        include DSLHelper
        include SessionsHelper
      end
    end
  end

  module DSLHelper
    def self.included(base)
      class << base
        alias_method :Given, :describe
        alias_method :And, :describe
        alias_method :When, :describe
      end

      RSpec::Core::ExampleGroup.class_eval do
        define_example_method :Then
        define_example_method :And_
        define_example_method :Or
      end
    end
  end

  module SessionsHelper
    def not_admin
      ApplicationController.class_eval do
        def admin?
          false
        end
      end
    end

    def sign_in_admin
      ApplicationController.class_eval do
        def admin?
          true
        end
      end
    end
  end
end

class Object
  alias_method :Scenario, :describe
end
