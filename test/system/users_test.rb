require "application_system_test_case"

class UsersTest < ApplicationSystemTestCase

  include ActionView::RecordIdentifier
  include Devise::Test::IntegrationHelpers

  # Admins

  test "admin views list" do
    sign_in(users(:admin))
    visit users_path
    assert_selector 'h1', text: 'Employees'
  end

  test "admin sees edit buttons for everyone" do
    sign_in(users(:admin))
    visit users_path
    within '#users_table tbody' do
      all('tr').each do |row|
        within row do
          assert_link 'Edit'
        end
      end
    end
  end

  test "admin sees delete buttons for everyone but themselves" do
    sign_in(users(:admin))
    visit users_path
    within '#users_table tbody' do
      all('tr').each do |row|
        if row[:id] == dom_id(users(:admin))
          within(row) { refute_link 'Delete' }
        else
          within(row) { assert_link 'Delete' }
        end
      end
    end
  end

  test "admin can view another user" do
    sign_in(users(:admin))
    visit user_path(users(:staff))
    assert_link 'Edit Profile'
  end

  # Staff

  test "staff cannot view user list" do
    sign_in(users(:staff))
    visit users_path
    assert_text 'not authorized'
  end

  test "staff cannot view another user" do
    sign_in(users(:staff))
    visit user_path(users(:admin))
    assert_text 'not authorized'
  end

  test "staff can view themselves" do
    sign_in(users(:staff))
    visit user_path(users(:staff))
    assert_text 'Employee Information'
  end

end
