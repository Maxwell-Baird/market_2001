require 'date'
require './lib/vendor'
require './lib/item'
class Market

  attr_reader :name, :vendors, :date

  def initialize(name)
    @name = name
    @vendors = []
  end

  def add_vendor(vendor)
    @vendors << vendor
  end

  def vendor_names
    @vendors.map {|vendor| vendor.name}
  end

  def vendors_that_sell(item)
    @vendors.find_all {|vendor| vendor.inventory.has_key?(item)}
  end

  def total_inventory
    total_items = {}
    @vendors.each do |vendor|
      vendor.inventory.each_key do |item|
        if total_items[item] == nil
          total_items[item] = {}
          total_items[item][:quantity] = 0
          total_items[item][:vendors] = []
        end
        total_items[item][:quantity] += vendor.inventory[item]
        total_items[item][:vendors] << vendor
      end
    end
    total_items
  end

  def sorted_item_list
    list_of_items = []
    @vendors.each do |vendor|
      vendor.inventory.each_key {|item| list_of_items << item.name}
    end
    list_of_items.uniq.sort
  end

  def overstocked_items
    overstocked = []
    total_inventory.each_key do |item|
      if (total_inventory[item][:quantity] > 50 && total_inventory[item][:vendors].length > 1)
        overstocked << item
      end
    end
    overstocked
  end

  def sell(item_wanted, amount)
    can_sell = false
    amount_need = amount
    total_inventory.each_key do |item|
      if item_wanted == item
        if total_inventory[item][:quantity] >= amount
          can_sell = true
          total_inventory[item][:vendors].each do |vendor|
            if amount_need > 0
              if amount_need >= vendor.inventory[item]
                amount_need -= vendor.inventory[item]
                vendor.inventory[item] = 0
              elsif amount_need < vendor.inventory[item]
                holder = vendor.inventory[item]
                vendor.inventory[item] -= amount_need
                amount_need -= holder
              end
            end
          end
        end
      end
    end
    can_sell
  end
end
