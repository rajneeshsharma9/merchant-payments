ENV['RAILS_ENV'] ||= 'test'
require 'spec_helper'
require File.expand_path("../../config/environment", __FILE__)

require 'rspec/rails'
require 'ffaker'
require 'rspec/active_model/mocks'
require 'shoulda/matchers'
require 'factory_bot'

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
  config.color = true
  config.order = "random"

  config.infer_spec_type_from_file_location!

  config.infer_base_class_for_anonymous_controllers = false
  config.include FactoryBot::Syntax::Methods


  config.expect_with :rspec do |expectations|
    expectations.syntax = [:expect]
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.syntax = [:expect]
    mocks.verify_partial_doubles = true
  end
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    # Choose a test framework:
    with.test_framework :rspec

    # Choose one or more libraries:
    # with.library :active_record
    # with.library :active_model
    # with.library :action_controller
    # Or, choose the following (which implies all of the above):
    with.library :rails
  end
end
