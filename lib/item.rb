class Item
  attr_reader :price, :name

  def initialize(hash_params)
    @name = hash_params[:name]
    @price = hash_params[:price][1..-1].to_f
  end
end
