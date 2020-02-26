class Vendor
  attr_reader :name, :inventory

  def initialize(name)
    @name = name
    @inventory = Hash.new(0)
  end

  def stock(item, amount)
    @inventory[item] += amount
  end

  def check_stock(item)
    @inventory[item]
  end

  def potential_revenue
    sum = 0
    @inventory.each_key {|item| sum += item.price * @inventory[item].to_f}
    sum
  end
end
