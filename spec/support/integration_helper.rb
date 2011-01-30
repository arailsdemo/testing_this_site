module MySpec
  module IntegrationHelper
    def self.included(base)
      base.class_eval do
        include DSLHelper
        include SessionsHelper
        include TodoHelper
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
        RSpec.hack_alert(self, __method__)
        def admin?
          false
        end
      end
    end

    def sign_in_admin
      ApplicationController.class_eval do
        RSpec.hack_alert(self, __method__)
        def admin?
          true
        end
      end
    end
  end

  module TodoHelper
    RSpec.module_eval do
      def self.hack_alert(klass, method)
        RSpec.configuration.reporter.hack_alert(klass, method)
      end
    end

    RSpec::Core::Reporter.class_eval do
      def hack_alert(klass, method)
        notify :message, "\nDuck Punched!: #{klass.name} #{method.to_s}"
      end
    end
  end
end

class Object
  alias_method :Scenario, :describe
end
