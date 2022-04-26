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

  test "admin sees edit buttons for other users" do
    sign_in(users(:admin))
    visit user_path(users(:staff))
    assert_link 'Edit'
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

  test "admin can archive users" do
    sign_in(users(:admin))
    visit user_path(users(:staff))
    click_on 'Archive'
    assert_text 'User was successfully archived'
    refute_text users(:staff).name
  end

  test "admin can recover an archived user" do
    sign_in(users(:admin))
    visit users_path
    refute_text users(:archived).name
    visit user_path(users(:archived))
    click_on 'Recover'
    assert_text 'User was successfully recovered'
    assert_text users(:archived).name
  end

  test "admin does not see delete button for themselves" do
    sign_in(users(:admin))
    visit user_path(users(:admin))
    refute_link 'Delete'
  end

  test "admin can delete other users" do
    sign_in(users(:admin))
    visit user_path(users(:workorderless))
    click_on 'Delete'
    assert_text 'User was successfully destroyed'
    refute_text users(:workorderless).name
  end

  test "admin can not delete a user that has associated work orders" do
    sign_in(users(:admin))
    visit user_path(work_orders.first.creator)
    click_on 'Delete'
    assert_text 'Cannot delete this user'
  end

  # Supervisors

  test "supervisor views list" do
    sign_in(users(:supervisor))
    visit users_path
    assert_selector 'h1', text: 'Employees'
  end

  test "supervisor can view another user" do
    sign_in(users(:supervisor))
    visit user_path(users(:staff))
    assert_selector 'h1', text: 'Employee Information'
  end

  test "supervisor does not see edit link when viewing other users" do
    sign_in(users(:supervisor))
    visit user_path(users(:staff))
    refute_link 'Edit'
  end

  test "supervisor does not see archive button" do
    sign_in(users(:supervisor))
    visit user_path(users(:staff))
    refute_link 'Archive'
  end

  test "supervisor does not see delete button" do
    sign_in(users(:supervisor))
    visit user_path(users(:staff))
    refute_link 'Delete'
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

  test "staff does not see archive button" do
    sign_in(users(:staff))
    visit user_path(users(:staff))
    refute_link 'Archive'
  end

  test 'staff do not see role and status options' do
    sign_in(users(:staff))
    visit edit_user_path(users(:staff))
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
