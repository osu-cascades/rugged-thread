require 'test_helper'

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  # Enable :selenium instead of :rack_test if we need client-side javascript
  # driven_by :selenium, using: :chrome, screen_size: [1400, 1400]

  driven_by :rack_test
  # To enable delete links (via data-method attribute) w/o javascript.
  Capybara.register_driver :rack_test do |app|
    Capybara::RackTest::Driver.new(app, respect_data_method: true)
  end

end
