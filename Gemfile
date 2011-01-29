source 'http://rubygems.org'

gem 'rails', '3.0.3'
gem 'sqlite3-ruby', :require => 'sqlite3'
gem 'haml-rails', '>= 0.3.4'
gem 'simple_form', '>= 1.3.0'

group :development, :test do
  gem 'rspec-rails', '>= 2.4.1'
  gem 'spork', '>= 0.9.0.rc2'

  if ENV["RUBY_VERSION"] =~ /ruby-1.9/
    gem 'ruby-debug19'
  else
    gem 'ruby-debug'
  end
end

group :test do
  gem 'factory_girl_rails', '1.1.beta1'

  gem 'capybara', '0.4.1.1'
  gem 'launchy', '0.3.7'
  gem 'database_cleaner', '0.6.0'

  gem 'webrat', '>= 0.7.3'
end
