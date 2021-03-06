require "minitest/autorun"
require "minitest/pride"
require './lib/item'
require './lib/vendor'

class VendorTest<Minitest::Test

  def test_it_exist
    vendor = Vendor.new("Rocky Mountain Fresh")
    assert_instance_of Vendor, vendor
  end

  def test_it_has_attributes
    vendor = Vendor.new("Rocky Mountain Fresh")
    assert_equal "Rocky Mountain Fresh", vendor.name
    expected = {}
    assert_equal expected, vendor.inventory
  end

  def test_it_can_check_stock
    item1 = Item.new({name: 'Peach', price: "$0.75"})
    vendor = Vendor.new("Rocky Mountain Fresh")
    assert_equal 0, vendor.check_stock(item1)
    vendor.stock(item1, 30)
    assert_equal 30, vendor.check_stock(item1)
    vendor.stock(item1, 25)
    assert_equal 55, vendor.check_stock(item1)
  end

  def test_it_can_update_invetory
    item2 = Item.new({name: 'Tomato', price: '$0.50'})
    item1 = Item.new({name: 'Peach', price: "$0.75"})
    vendor = Vendor.new("Rocky Mountain Fresh")
    vendor.stock(item1, 30)
    expected1 = {item1 => 30}
    assert_equal expected1, vendor.inventory
    expected2 = {item1 => 30, item2 => 15}
    vendor.stock(item2, 15)
    assert_equal expected2, vendor.inventory
  end

  def test_it_can_find_potential_revenue
    item1 = Item.new({name: 'Tomato', price: '$0.50'})
    item2 = Item.new({name: 'Peach', price: "$0.75"})
    vendor = Vendor.new("Rocky Mountain Fresh")
    vendor.stock(item1, 30)
    vendor.stock(item2, 15)
    assert_equal 26.25, vendor.potential_revenue
  end
end
