# Configure Rails Environment
ENV["RAILS_ENV"] = "test"

require File.expand_path("../../test/dummy/config/environment.rb",  __FILE__)
# ActiveRecord::Migrator.migrations_paths = [File.expand_path("../../test/dummy/db/migrate", __FILE__)]
# ActiveRecord::Migrator.migrations_paths << File.expand_path('../../db/migrate', __FILE__)
require "rails/test_help"

# Filter out Minitest backtrace while allowing backtrace from other libraries
# to be shown.
Minitest.backtrace_filter = Minitest::BacktraceFilter.new

# Load fixtures from the engine
if ActiveSupport::TestCase.respond_to?(:fixture_path=)
  ActiveSupport::TestCase.fixture_path = File.expand_path("../fixtures", __FILE__)
end

require 'capybara/rails'
require 'capybara/poltergeist'
require "timeout"

SANDBOX_PATH = Pathname.new(File.expand_path("sandbox", __dir__))
SANDBOX_PATH.each_child do |screenshot|
  next if screenshot.basename.to_s == '.gitkeep'
  screenshot.delete
end

class ActionDispatch::IntegrationTest
  include Capybara::DSL
  Capybara.default_driver = :poltergeist

  def teardown
    super
    Capybara.reset_sessions!    # Forget the (simulated) browser state
    Capybara.use_default_driver # Revert Capybara.current_driver to Capybara.default_driver
  end
end
