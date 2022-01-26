require "test_helper"

class BrandTest < ActiveSupport::TestCase

  test 'has many items' do
    assert_respond_to(Brand.new, :items)
  end

  test 'Brand has a name' do
    assert_respond_to(Brand.new, :name)
  end

  test 'Brand without a name is invalid' do
    brand = brands(:one)
    assert brand.valid?
    brand.name = nil
    refute brand.valid?
  end

  test 'Brand with a non-unique name is invalid' do
    existing_brand_name = brands(:one).name
    brand = brands(:two)
    assert brand.valid?
    brand.name = existing_brand_name
    refute brand.valid?
  end
end
