require "test_helper"

class StandardComplicationTest < ActiveSupport::TestCase

  test "attribtues" do
    assert_respond_to(StandardComplication.new, :name)
    assert_respond_to(StandardComplication.new, :method)
    assert_respond_to(StandardComplication.new, :description)
    assert_respond_to(StandardComplication.new, :level)
    assert_respond_to(StandardComplication.new, :charge)
  end

  test "associations" do
    assert_respond_to(StandardComplication.new, :standard_repair)
    skip
    assert_respond_to(StandardComplication.new, :complications)
  end

  test 'cannot be deleted if it has associated complications' do
    skip
    standard_repair = standard_repairs(:one)
    assert_not_empty standard_repair.repairs
    standard_repair.destroy
    refute standard_repair.destroyed?
  end

  test 'is not valid without a name' do
    standard_repair = standard_repairs(:one)
    assert standard_repair.valid?
    standard_repair.name = ''
    refute standard_repair.valid?
  end

  test 'level must be a positive integer' do
    standard_repair = standard_repairs(:one)
    assert standard_repair.valid?
    standard_repair.level = -1
    refute standard_repair.valid?
  end

  test 'level is 1 by default' do
    standard_repair = StandardComplication.new
    assert_equal 1, standard_repair.level
  end

  test 'charge must be a positive integer' do
    standard_repair = standard_repairs(:one)
    assert standard_repair.valid?
    standard_repair.charge = -1
    refute standard_repair.valid?
  end

  test "#to_s string representation is name" do
    name = 'FAKE'
    standard_repair = StandardComplication.new(name: name)
    assert_equal name, standard_repair.to_s
  end

end
