require "test_helper"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  #driven_by :selenium, using: :firefox, screen_size: [1400, 1400]
  def setup
    Capybara.register_driver "selenium_remote_chrome".to_sym do |app|
      Capybara::Selenium::Driver.new(app, browser: :remote, url: "http://localhost:4445/wd/hub", desired_capabilities: :chrome)
    end
    Capybara.javascript_driver = :selenium_remote_chrome
    Capybara.current_driver = :selenium_remote_chrome
  end
end
