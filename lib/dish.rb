class Dish
  attr_reader :name, :price

  def initialize(name = "Hash brown", price = 0.99)
    @name = name
    @price = price
    @hash = {name => price}
  end

  def itemise
    @hash[@name] = @price.round(2)
    @hash
  end
end
