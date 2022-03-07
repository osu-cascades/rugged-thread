require "test_helper"

class WorkOrderTest < ActiveSupport::TestCase

  test 'attributes'do
    assert_respond_to(WorkOrder.new, :in_date)
    assert_respond_to(WorkOrder.new, :due_date)
    assert_respond_to(WorkOrder.new, :shipping)
  end

  test 'associations' do
    assert_respond_to(WorkOrder.new, :creator)
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

  test 'is invalid without a date in' do
    work_order = work_orders(:shipping)
    assert work_order.valid?
    work_order.in_date = nil
    refute work_order.valid?
    work_order.in_date = ''
    refute work_order.valid?
  end

  test 'is invalid without a due date' do
    work_order = work_orders(:shipping)
    assert work_order.valid?
    work_order.due_date = nil
    refute work_order.valid?
    work_order.due_date = ''
    refute work_order.valid?
  end

  test 'due date must be after date in' do
    work_order = work_orders(:shipping)
    assert work_order.valid?
    work_order.due_date = work_order.in_date
    refute work_order.valid?
  end

  test 'is invalid without a creator' do
    work_order = work_orders(:shipping)
    assert work_order.valid?
    work_order.creator = nil
    refute work_order.valid?
  end

  test 'is invalid without a customer' do
    work_order = work_orders(:shipping)
    assert work_order.valid?
    work_order.customer = nil
    refute work_order.valid?
  end

  test 'due date is customer type turn-around days from current date' do
    work_order = customers.first.work_orders.build
    turn_around = customers.first.customer_type.turn_around
    assert_equal Date.current + turn_around, work_order.due_date
  end

  test '#estimate is the sum of all item estimates' do
    work_order = work_orders(:itemless)
    assert_equal(0, work_order.estimate)
    item = Item.new
    def item.estimate
      99
    end
    work_order.items << item
    assert_equal(99, work_order.estimate)
  end

end
