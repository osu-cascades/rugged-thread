require "test_helper"

class ItemTypeTest < ActiveSupport::TestCase

  test 'has many items' do
    assert_respond_to(ItemType.new, :items)
  end

  test 'cannot be deleted if it has associated items' do
    item_type = item_types(:one)
    assert_not_empty item_type.items
    item_type.destroy
    refute item_type.destroyed?
  end

  test 'Item Type has a name' do
    assert_respond_to(ItemType.new, :name)
  end

  test 'Item Type without a name is invalid' do
    item_type = item_types(:one)
    assert item_type.valid?
    item_type.name = nil
    refute item_type.valid?
  end

  test 'Item Type with a non-unique name is invalid' do
    existing_item_type_name = item_types(:one).name
    item_type = item_types(:two)
    assert item_type.valid?
    item_type.name = existing_item_type_name
    refute item_type.valid?
  end
end
