require "test_helper"

class AccountTest < ActiveSupport::TestCase

  test 'Account has a name' do
    assert_respond_to(Account.new, :name)
  end

  test 'Account without a name is invalid' do
    account = accounts(:one)
    assert account.valid?
    account.name = nil
    refute account.valid?
  end

  test 'Account with a non-unique name is invalid' do
    existing_account_name = accounts(:one).name
    account = accounts(:two)
    assert account.valid?
    account.name = existing_account_name
    refute account.valid?
  end

  test '#to_s string representation is name' do
    name = 'FAKE'
    account = Account.new(name: name)
    assert_equal name, account.to_s
  end

end
