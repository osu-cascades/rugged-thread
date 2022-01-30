require "test_helper"

class WorkOrderTest < ActiveSupport::TestCase

  test 'attributes'do
    assert_respond_to(WorkOrder.new, :in_date)
    assert_respond_to(WorkOrder.new, :shipping)
  end

  test 'relationships' do
    assert_respond_to(WorkOrder.new, :customer)
    assert_respond_to(WorkOrder.new, :items)
  end

  test "cannot be deleted if it has associated items" do
    work_order = work_orders(:shipping)
    assert_not_empty work_order.items
    work_order.destroy
    refute work_order.destroyed?
  end

  test '#to_s string representation' do
    work_order = work_orders(:shipping)
    expected = "Work Order #{work_order.id}"
    assert_equal expected, work_order.to_s
  end

  test 'is invalid without a date' do
    work_order = work_orders(:shipping)
    assert work_order.valid?
    work_order.in_date = nil
    refute work_order.valid?
    work_order.in_date = ''
    refute work_order.valid?
  end

end
