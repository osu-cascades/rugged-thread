require "test_helper"

class UserTest < ActiveSupport::TestCase

  test "#to_s returns the name" do
    name = 'FAKE'
    user = User.new(name: name)
    assert_equal name, user.to_s
  end

end
