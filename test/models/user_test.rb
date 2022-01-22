require "test_helper"

class UserTest < ActiveSupport::TestCase

  test "#to_s returns the name" do
    name = 'FAKE'
    user = User.new(name: name)
    assert_equal name, user.to_s
  end

  test "is invalid without a name" do
    user = users(:one)
    assert user.valid?
    user.name = nil
    refute user.valid?
    user.name = ''
    refute user.valid?
  end

end
