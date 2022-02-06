require "test_helper"

class RepairTest < ActiveSupport::TestCase

  test "associations" do
    assert_respond_to(Repair.new, :item)
    assert_respond_to(Repair.new, :standard_repair)
  end

end
