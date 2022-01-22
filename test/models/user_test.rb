require "test_helper"

class UserTest < ActiveSupport::TestCase

  def new_user
    User.new(email: 'new_fake_user@example.com', name: 'FAKE',
      password: 'password', password_confirmation: 'password',
      role: 'staff', status: 'active')
  end

  test "has a default role of staff" do
    new_user = User.new
    assert_equal new_user.role, 'staff'
  end

  test "pre-existing User without defined role has a default role of staff" do
    assert_equal users(:vague).role, 'staff'
  end

  test "has an active status by default" do
    new_user = User.new
    assert_equal new_user.status, 'active'
  end

  test "pre-existing User without defined status has a default status of active" do
    assert_equal users(:vague).status, 'active'
  end

  test 'active user is active_for_authentication' do
    u = new_user
    assert u.active_for_authentication?
  end

  test 'inactive user is not active_for_authentication' do
    u = new_user
    u.inactive!
    refute u.active_for_authentication?
  end

  test "has a required name" do
    user = users(:one)
    assert user.valid?
    user.name = nil
    refute user.valid?
    user.name = ''
    refute user.valid?
  end

  test "#to_s string representation is name" do
    name = 'FAKE'
    user = User.new(name: name)
    assert_equal name, user.to_s
  end

end
