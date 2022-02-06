require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test 'requires user authentication' do
    assert(defines_before_filter?(UsersController, :authenticate_user!))
  end

  test 'redirects requests from unauthenticated sessions' do
    # index
    get users_path
    assert_redirected_to new_user_session_path
    # show
    get user_path(id: 'fake')
    assert_redirected_to new_user_session_path
    # new
    get new_user_path
    assert_redirected_to new_user_session_path
    # edit
    get edit_user_path(id: 'fake')
    assert_redirected_to new_user_session_path
    # create
    post users_path()
    assert_redirected_to new_user_session_path
    # update
    patch user_path(id: 'fake')
    assert_redirected_to new_user_session_path
    put user_path(id: 'fake')
    assert_redirected_to new_user_session_path
    # destroy
    delete "/admin/users/fake"
    assert_redirected_to new_user_session_path
  end

  test 'redirects requests from deactivated users' do
    sign_in users(:deactivated)
    # index
    get users_path
    assert_redirected_to new_user_session_path
    # show
    get user_path(id: 'fake')
    assert_redirected_to new_user_session_path
    # new
    get new_user_path
    assert_redirected_to new_user_session_path
    # edit
    get edit_user_path(id: 'fake')
    assert_redirected_to new_user_session_path
    # create
    post users_path()
    assert_redirected_to new_user_session_path
    # update
    patch user_path(id: 'fake')
    assert_redirected_to new_user_session_path
    put user_path(id: 'fake')
    assert_redirected_to new_user_session_path
    # destroy
    delete "/admin/users/fake"
    assert_redirected_to new_user_session_path
  end

  test 'redirects requests from staff users to root url' do
    sign_in users(:staff)
    # index
    get users_path
    assert_redirected_to root_url
    # show
    get user_path(users(:admin))
    assert_redirected_to root_url
    # new
    get new_user_path
    assert_redirected_to root_url
    # edit
    get edit_user_path(users(:admin))
    assert_redirected_to root_url
    # create
    post users_path({user: {name: 'FAKE'}})
    assert_redirected_to root_url
    # update
    patch user_path(users(:admin), user: {name: 'FAKE'})
    assert_redirected_to root_url
    put user_path(users(:admin), user: {name: 'FAKE'})
    assert_redirected_to root_url
    # destroy
    delete "/admin/users/#{users(:staff).id}"
    assert_redirected_to root_url
  end

  test 'redirects requests from FOH users to root url' do
    sign_in users(:foh)
    # index
    get users_path
    assert_redirected_to root_url
    # show
    get user_path(users(:admin))
    assert_redirected_to root_url
    # new
    get new_user_path
    assert_redirected_to root_url
    # edit
    get edit_user_path(users(:admin))
    assert_redirected_to root_url
    # create
    post users_path({user: {name: 'FAKE'}})
    assert_redirected_to root_url
    # update
    patch user_path(users(:admin), user: {name: 'FAKE'})
    assert_redirected_to root_url
    put user_path(users(:admin), user: {name: 'FAKE'})
    assert_redirected_to root_url
    # destroy
    delete "/admin/users/#{users(:foh).id}"
    assert_redirected_to root_url
  end

  test 'redirects requests from supervisor users to root url' do
    sign_in users(:supervisor)
    # new
    get new_user_path
    assert_redirected_to root_url
    # edit
    get edit_user_path(users(:admin))
    assert_redirected_to root_url
    # create
    post users_path({user: {name: 'FAKE'}})
    assert_redirected_to root_url
    # update
    patch user_path(users(:admin), user: {name: 'FAKE'})
    assert_redirected_to root_url
    put user_path(users(:admin), user: {name: 'FAKE'})
    assert_redirected_to root_url
    # destroy
    delete "/admin/users/#{users(:supervisor).id}"
    assert_redirected_to root_url
  end

end
