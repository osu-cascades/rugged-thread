require "test_helper"

class ShopParameterTest < ActiveSupport::TestCase

  test 'Shop Parameter has a name' do
    assert_respond_to(ShopParameter.new, :name)
  end

  test 'Shop Parameter without a name is invalid' do
    shop_parameter = shop_parameters(:one)
    assert shop_parameter.valid?
    shop_parameter.name = nil
    refute shop_parameter.valid?
  end

  test 'Shop Parameter with a non-unique name is invalid' do
    existing_shop_parameter_name = shop_parameters(:one).name
    shop_parameter = shop_parameters(:two)
    assert shop_parameter.valid?
    shop_parameter.name = existing_shop_parameter_name
    refute shop_parameter.valid?
  end

  test '#to_s string representation is name' do
    name = 'FAKE'
    amount = 1
    expected = "#{name} $#{amount}"
    shop_parameter = ShopParameter.new(name: name, amount: amount)
    assert_equal expected, shop_parameter.to_s
  end

end
