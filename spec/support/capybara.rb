# frozen_string_literal: true
require 'capybara/rails'
require 'capybara/rspec'
require 'capybara/poltergeist'

Capybara.register_driver :selenium do |app|
  Capybara::Selenium::Driver.new(app, browser: :chrome)
end
Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app, {js_errors: false})
end
# Capybara.javascript_driver = :selenium
Capybara.javascript_driver = :poltergeist
Capybara.server_host = 'localhost'
Capybara.raise_server_errors = false