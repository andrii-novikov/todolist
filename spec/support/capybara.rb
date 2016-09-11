require 'capybara/rails'
require 'capybara/rspec'
require 'capybara/poltergeist'

Capybara.register_driver :selenium do |app|
  Capybara::Selenium::Driver.new(app, :browser => :chrome)
end
# Capybara.javascript_driver = :selenium
Capybara.javascript_driver = :poltergeist
Capybara.server_host = 'localhost'
Capybara.raise_server_errors = false

