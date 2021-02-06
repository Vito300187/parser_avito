# frozen_string_literal: true

require 'capybara'
require 'capybara/rspec'
require 'capybara-screenshot/rspec'
require 'pry'
require 'rtesseract'
require 'selenium/webdriver'
require_relative 'helpers/helpers'

FileUtils.mkdir_p('screenshots')
Capybara::Screenshot.autosave_on_failure = false
Capybara.configure { |config| config.default_driver = :chrome }
Capybara.javascript_driver = :chrome
Capybara.default_max_wait_time = 15
Capybara.ignore_hidden_elements = true
Capybara.save_path = './screenshots'

Capybara.register_driver :chrome do |app|
  chrome_args = []
  chrome_args << %w[headless disable-gpu]
  chrome_args.flatten!
  capabilities = Selenium::WebDriver::Remote::Capabilities.chrome('goog:chromeOptions': { args: chrome_args })

  Capybara::Selenium::Driver.new(
    app,
    browser: :chrome,
    desired_capabilities: capabilities,
    clear_local_storage: true,
    clear_session_storage: true
  )
end

# RSpec.configure { Capybara.page.driver.browser.manage.window.resize_to(1920, 1080) }

def screenshots_folder_files
  Dir.glob('screenshots/*')
end
