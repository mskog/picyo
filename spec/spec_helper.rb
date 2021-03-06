ENV["RAILS_ENV"] ||= 'test'

require 'rubygems'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec-given'
require 'database_cleaner'
require 'webmock/rspec'
require 'pundit/rspec' 

unless ENV['DRB']
  require "codeclimate-test-reporter"
  CodeClimate::TestReporter.configure do |config|
    config.logger.level = Logger::WARN
  end

  CodeClimate::TestReporter.start
end

WebMock.disable_net_connect! allow: [/codeclimate\.com/]

load File.join(Rails.root, 'Rakefile')

Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end

RSpec.configure do |config|
  config.run_all_when_everything_filtered = true
  config.infer_spec_type_from_file_location!
  config.filter_run :focus

  config.order = 'random'

  config.include FactoryGirl::Syntax::Methods

  config.expect_with :rspec do |c|
     c.syntax = [:expect]
   end

  config.before(:suite) do
    DatabaseCleaner.clean_with :truncation
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before :each do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

   config.before(:all) do
     FactoryGirl.reload
   end

   config.include AuthHelper, :type => :request
end
