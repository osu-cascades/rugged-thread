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
    assert_selector 'h1', text: 'Employee Information'
  end

  test "admin can create a new user" do
    sign_in(users(:admin))
    visit new_user_path
    assert_selector 'h1', text: 'New Employee'
    fill_in 'Name', with: 'New Fake User'
    fill_in 'Email', with: 'newfake@example.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    select 'Admin', from: 'Role'
    click_on 'Save'
    assert_text 'User was successfully created'
  end

  test "admin can edit other users" do
    new_name = 'CHANGED Fake User'
    sign_in(users(:admin))
    visit edit_user_path(users(:staff))
    assert_selector 'h1', text: "Editing #{users(:staff)}"
    fill_in 'Name', with: new_name
    click_on 'Save'
    assert_text 'User was successfully updated'
    assert_text new_name
  end

  test "admin can delete other users" do
    sign_in(users(:admin))
    visit users_path
    within "##{dom_id(users(:staff))}" do
      click_on 'Delete'
    end
    assert_text 'User was successfully destroyed'
    refute_text users(:staff).name
  end

  # Supervisors

  test "supervisor views list" do
    sign_in(users(:supervisor))
    visit users_path
    assert_selector 'h1', text: 'Employees'
  end

  test "supervisor does not see edit buttons for anyone but themselves" do
    sign_in(users(:supervisor))
    visit users_path
    within '#users_table tbody' do
      all('tr').each do |row|
        if row[:id] == dom_id(users(:supervisor))
          within(row) { assert_link 'Edit' }
        else
          within(row) { refute_link 'Edit' }
        end
      end
    end
  end

  test "supervisor does not see delete buttons" do
    sign_in(users(:supervisor))
    visit users_path
    within '#users_table tbody' do
      all('tr').each do |row|
        within(row) { refute_link 'Delete' }
      end
    end
  end

  test "supervisor can view another user" do
    sign_in(users(:supervisor))
    visit user_path(users(:staff))
    assert_selector 'h1', text: 'Employee Information'
  end

  test "supervisor does not see edit link when viewing other users" do
    sign_in(users(:supervisor))
    visit user_path(users(:staff))
    refute_link 'Edit Profile'
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

  test 'staff do not see role and status options' do
    sign_in(users(:staff))
    visit user_path(users(:staff))
    refute_text 'Role and Status'
    refute_select 'Role'
  end

  test "staff cannot see new user form" do
    sign_in(users(:staff))
    visit new_user_path
    assert_text 'not authorized'
  end

  test "staff cannot edit another user" do
    sign_in(users(:staff))
    visit edit_user_path(users(:admin))
    assert_text 'not authorized'
  end

  test "staff can edit themselves" do
    new_name = 'CHANGED Fake User'
    sign_in(users(:staff))
    visit edit_user_path(users(:staff))
    assert_text "Editing #{users(:staff)}"
    fill_in 'Name', with: new_name
    click_on 'Save'
    assert_text 'User was successfully updated'
    assert_text new_name
  end

end
