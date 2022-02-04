require "test_helper"

class StandardRepairTest < ActiveSupport::TestCase

  test "attribtues" do
    assert_respond_to(StandardRepair.new, :name)
    assert_respond_to(StandardRepair.new, :method)
    assert_respond_to(StandardRepair.new, :description)
    assert_respond_to(StandardRepair.new, :charge)
  end

  test "associations" do
    assert_respond_to(StandardRepair.new, :repairs)
  end

  test 'cannot be deleted if it has associated repairs' do
    standard_repair = standard_repairs(:one)
    assert_not_empty standard_repair.repairs
    standard_repair.destroy
    refute standard_repair.destroyed?
  end

  test "#to_s string representation is name" do
    name = 'FAKE'
    standard_repair = StandardRepair.new(name: name)
    assert_equal name, standard_repair.to_s
  end

end
