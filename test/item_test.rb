require "minitest/autorun"
require "minitest/pride"
require './lib/item'

class ItemTest < Minitest::Test

  def test_it_exist
    item1 = Item.new({name: 'Peach', price: "$0.75"})
    assert_instance_of Item, item1
  end
end
