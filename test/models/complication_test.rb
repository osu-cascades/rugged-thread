require "test_helper"

class ComplicationTest < ActiveSupport::TestCase

  test "attributes" do
    assert_respond_to(Complication.new, :price)
  end

  test "associations" do
    assert_respond_to(Complication.new, :standard_complication)
    assert_respond_to(Complication.new, :repair)
  end

  test "must have a standard complication" do
    complication = complications(:one)
    assert complication.valid?
    complication.standard_complication = nil
    refute complication.valid?
  end

  test "must have a repair" do
    complication = complications(:one)
    assert complication.valid?
    complication.repair = nil
    refute complication.valid?
  end

  test "has a price that is the default complication price" do
    complication = Complication.new
    assert_equal(complication.price, 0)
  end

  test 'price must be a positive integer' do
    complication = complications(:one)
    assert complication.valid?
    complication.price = -1
    refute complication.valid?
  end

  test '#name is the standard complication name' do
    complication = complications(:one)
    assert_equal complication.standard_complication.name, complication.name
  end

  test '#to_s string representation is name' do
    complication = complications(:one)
    assert_equal complication.name, complication.to_s
  end

end
