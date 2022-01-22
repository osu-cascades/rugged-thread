require "test_helper"

class ItemStatusTest < ActiveSupport::TestCase
  test 'Item Status has a name' do
    assert_respond_to(ItemStatus.new, :name)
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
end
