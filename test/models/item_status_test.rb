require "test_helper"

class ItemStatusTest < ActiveSupport::TestCase

  test 'attributes' do
    assert_respond_to(ItemStatus.new, :name)
    assert_respond_to(ItemStatus.new, :default)
  end

  test 'default has a false default value' do
    assert_equal(ItemStatus.new.default, false)
  end

  test 'has many items' do
    assert_respond_to(ItemStatus.new, :items)
  end

  test 'cannot be deleted if it has associated items' do
    item_status = item_statuses(:one)
    assert_not_empty item_status.items
    item_status.destroy
    refute item_status.destroyed?
  end

  test 'cannot be deleted if it is the default' do
    default_item_status = item_statuses(:default)
    default_item_status.destroy
    refute default_item_status.destroyed?
  end

  test 'Item Status without a name is invalid' do
    item_status = item_statuses(:one)
    assert item_status.valid?
    item_status.name = nil
    refute item_status.valid?
  end

  test 'Item Status with a non-unique name is invalid' do
    existing_item_status_name = item_statuses(:one).name
    item_status = item_statuses(:two)
    assert item_status.valid?
    item_status.name = existing_item_status_name
    refute item_status.valid?
  end

  test 'there can only be one default item status' do
    refute_nil ItemStatus.default
    item_status = item_statuses(:one)
    assert item_status.valid?
    item_status.default = true
    refute item_status.valid?
  end

  test "#make_default! makes the item status the sole default" do
    item_status = item_statuses(:one)
    refute_equal item_status, ItemStatus.default
    item_status.make_default!
    assert_equal item_status, ItemStatus.default
  end

  test '#to_s string representation is name' do
    name = 'FAKE'
    item_status = ItemStatus.new(name: name)
    assert_equal name, item_status.to_s
  end

  test "::default returns the default item status" do
    item_status = ItemStatus.default
    assert_equal true, item_status.default
  end

  test "cannot be archived if it is the default" do
    default_item_status = item_statuses(:default)
    default_item_status.discard
    refute default_item_status.discarded?
  end

end
