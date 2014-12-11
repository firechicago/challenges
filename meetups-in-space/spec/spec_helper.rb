ENV["RACK_ENV"] ||= "test"

require 'pry'
require 'rspec'
require 'capybara/rspec'
require 'factory_girl'
require 'factories'
require 'database_cleaner'
# require 'rack_session_access'
# require 'rack_session_access/capybara'
# require 'rack_session_access/middleware'
require_relative '../app.rb'

# RSpec.configure do |config|
#   # if you want to build(:user) instead of Factory.build(:user)
#   config.include Factory::Syntax::Methods
# end

Capybara.app = Sinatra::Application

RSpec::Matchers.define :order_text do |first, second|
  match do |page|
    page.text.index(first) < page.text.index(second)
  end
  failure_message do
    "\"#{first}\" does not appear before \"#{second}\""
  end
end

RSpec.configure do |config|
  config.filter_run :focus
  config.run_all_when_everything_filtered = true

  config.before :each do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.start

    # Short circuit any OAuth authentication requests. Requires a mock
    # authentication hash to be set for login to work.
    OmniAuth.config.test_mode = true
    # This suppresses any warnings from polluting the test output.
    # http://stackoverflow.com/questions/19483367/rails-omniauth-error-in-rspec-output
    OmniAuth.config.logger = Logger.new("/dev/null")
  end

  config.after :each do
    DatabaseCleaner.clean
  end
end
