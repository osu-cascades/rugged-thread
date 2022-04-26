require "test_helper"

class ItemTest < ActiveSupport::TestCase

  test "attributes" do
    assert_respond_to(Item.new, :due_date)
    assert_respond_to(Item.new, :notes)
    assert_respond_to(Item.new, :shipping)
    assert_respond_to(Item.new, :position)
  end

  test "associations" do
    assert_respond_to(Item.new, :brand)
    assert_respond_to(Item.new, :item_status)
    assert_respond_to(Item.new, :item_type)
    assert_respond_to(Item.new, :work_order)
    assert_respond_to(Item.new, :repairs)
    assert_respond_to(Item.new, :discounts)
    assert_respond_to(Item.new, :fees)
  end

  test "can be deleted if it has no associated repairs, discounts, or fees" do
    item = items(:associationless)
    assert_empty item.repairs
    assert_empty item.discounts
    assert_empty item.fees
    item.destroy
    assert item.destroyed?
  end

  test "cannot be deleted if it has repairs" do
    item = items(:with_only_repair)
    assert_empty item.discounts
    assert_empty item.fees
    assert_not_empty item.repairs
    item.destroy
    refute item.destroyed?
  end

  test "cannot be deleted if it has discounts" do
    item = items(:with_only_discount)
    assert_empty item.fees
    assert_empty item.repairs
    assert_not_empty item.discounts
    item.destroy
    refute item.destroyed?
  end

  test "cannot be deleted if it has fees" do
    item = items(:with_only_fee)
    assert_empty item.discounts
    assert_empty item.repairs
    assert_not_empty item.fees
    item.destroy
    refute item.destroyed?
  end

  test "must have a brand" do
    item = items(:one)
    assert item.valid?
    item.brand = nil
    refute item.valid?
  end

  test "must have a status" do
    item = items(:one)
    assert item.valid?
    item.item_status = nil
    refute item.valid?
  end

  test "must have a type" do
    item = items(:one)
    assert item.valid?
    item.item_type = nil
    refute item.valid?
  end

  test "must have a work order" do
    item = items(:one)
    assert item.valid?
    item.work_order = nil
    refute item.valid?
  end

  test "must have a due date" do
    item = items(:one)
    assert item.valid?
    item.due_date = nil
    refute item.valid?
  end

  test "must have a due date greater than its work order's in date" do
    item = items(:one)
    assert item.valid?
    item.due_date = item.work_order.in_date
    refute item.valid?
  end

  test "has a default status when item status is not present" do
    item = Item.new
    assert_equal ItemStatus.default, item.item_status
  end

  test "does not have a default status when it already has a status" do
    item = Item.new(item_status: item_statuses(:two))
    refute_equal ItemStatus.default, item.item_status
  end

  test "shipping must be true or false" do
    item = items(:one)
    assert item.valid?
    item.shipping = nil
    refute item.valid?
  end

  test "shipping is the same as its work order upon build" do
    shipping_work_order = work_orders(:shipping)
    item = shipping_work_order.items.build
    assert shipping_work_order.shipping
    assert item.shipping
    not_shipped_work_order = work_orders(:not_shipping)
    item = not_shipped_work_order.items.build
    refute not_shipped_work_order.shipping
    refute item.shipping
  end

  test "shipping is nil when created without a work order" do
    assert_nil Item.new.shipping
  end

  test "shipping does not update to match work order when item is already persisted" do
    item = items(:one)
    assert_equal item.work_order.shipping, item.shipping
    item.shipping = !item.work_order.shipping
    item.save!
    item = items(:one)
    refute_equal item.work_order.shipping, item.shipping
  end

  test "due date is the same as its work order upon build" do
    work_order = work_orders(:shipping)
    item = work_order.items.build
    assert_equal work_order.shipping, item.shipping
  end

  test "due date is nil when created without a work order" do
    assert_nil Item.new.due_date
  end

  test "due date does not update to match work order when item is already persisted" do
    item = items(:one)
    item.due_date = item.due_date + 1.day
    item.save!
    refute_equal item.work_order.due_date, item.due_date
  end

  test "#price is price of repairs and fees minus discounts" do
    item = items(:associationless)
    item.repairs << Repair.new(price_cents: 50)
    item.fees << Fee.new(price_cents: 50)
    assert_equal(Money.from_cents(100), item.price)
    item.discounts << Discount.new(percentage_amount: 50)
    item.discounts << Discount.new(price_cents: 1)
    assert_equal(Money.from_cents(49), item.price)
  end

  test "#price_total_discount" do
    item = items(:associationless)
    assert_equal(Money.from_cents(0), item.price_total_discount)
    item.repairs << Repair.new(price_cents: 50)
    item.fees << Fee.new(price_cents: 50)
    item.discounts << Discount.new(percentage_amount: 50)
    item.discounts << Discount.new(price_cents: 1)
    assert_equal(Money.from_cents(51), item.price_total_discount)
  end

  test "#price_of_repairs_and_fees is the sum of repair prices and fee prices" do
    item = items(:associationless)
    assert_equal(Money.from_cents(0), item.price_of_repairs)
    item.repairs << Repair.new(price_cents: 3)
    item.fees << Fee.new(price_cents: 3)
    assert_equal(Money.from_cents(6), item.price_of_repairs_and_fees)
    item.repairs << Repair.new(price_cents: 7)
    item.fees << Fee.new(price_cents: 1)
    assert_equal(Money.from_cents(14), item.price_of_repairs_and_fees)
  end

  test "#price_of_labor is the sum of all repair prices" do
    item = items(:associationless)
    assert_equal(Money.from_cents(0), item.price_of_labor)
    repair = Repair.new(price_cents: 3)
    repair.complications << Complication.new(price_cents: 1)
    item.repairs << repair
    assert_equal(Money.from_cents(4), item.price_of_labor)
    item.repairs << Repair.new(price_cents: 7)
    assert_equal(Money.from_cents(11), item.price_of_labor)
  end

  test "#price_of_repairs is the sum of all repair prices" do
    item = items(:associationless)
    assert_equal(Money.from_cents(0), item.price_of_repairs)
    item.repairs << Repair.new(price_cents: 3)
    assert_equal(Money.from_cents(3), item.price_of_repairs)
    item.repairs << Repair.new(price_cents: 7)
    assert_equal(Money.from_cents(10), item.price_of_repairs)
  end

  test "#percentage_discount is the sum of all percentage discounts" do
    item = items(:associationless)
    assert_equal(0, item.percentage_discount)
    item.discounts << Discount.new(percentage_amount: 1)
    item.discounts << Discount.new(percentage_amount: 2)
    assert_equal(3, item.percentage_discount)
  end

  test "#dollar_discount is the sum of all dollar discounts" do
    item = items(:associationless)
    assert_equal(Money.from_cents(0), item.dollar_discount)
    item.discounts << Discount.new(price_cents: 3)
    item.discounts << Discount.new(price_cents: 4)
    assert_equal(Money.from_cents(7), item.dollar_discount)
  end

  test "#price_of_fees is the sum of all fees" do
    item = items(:associationless)
    assert_equal(Money.from_cents(0), item.price_of_fees)
    item.fees << Fee.new(price_cents: 3)
    item.fees << Fee.new(price_cents: 4)
    assert_equal(Money.from_cents(7), item.price_of_fees)
  end

  test "#level is the maximum level of its repirs" do
    assert_equal(3, items(:one).level)
  end

  test "#expedite? is true if any of the fees are the expedite fee" do
    item = Item.new
    refute item.expedite?
    item.fees << Fee.new(standard_fee: StandardFee.new(name: StandardFee::EXPEDITE_FEE_NAME))
    assert item.expedite?
  end

end
