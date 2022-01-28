require "test_helper"

class BrandTest < ActiveSupport::TestCase

  test 'has many items' do
    assert_respond_to(Brand.new, :items)
  end

  test 'cannot be deleted if it has associated items' do
    brand = brands(:one)
    assert_not_empty brand.items
    brand.destroy
    refute brand.destroyed?
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

  test '#to_s string representation is name' do
    name = 'FAKE'
    brand = Brand.new(name: name)
    assert_equal name, brand.to_s
  end


end
