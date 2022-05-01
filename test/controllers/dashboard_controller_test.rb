require "test_helper"

class DashboardControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test 'requires user authentication' do
    assert(defines_before_filter?(UsersController, :authenticate_user!))
  end

  test 'redirects requests from unauthenticated sessions' do
    # show
    get dashboard_path
    assert_redirected_to new_user_session_path
  end

  test 'redirects requests from deactivated users' do
    sign_in users(:deactivated)
    # show
    get dashboard_path
    assert_redirected_to new_user_session_path
  end

end
