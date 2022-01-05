require_relative 'twilio_text'

class Order 
  attr_reader :my_order 

  def initialize
    @my_order = []
  end

  def add_dish_to_order(name, quantity)
    @name, @quantity = name, quantity
    @my_order << { @name => @quantity }
    return "#{quantity} x #{name} added to your order"
  end

  def view_order
    order_display
  end


  def how_much
    puts "Customer to pay £#{order_total}"
  end

  def order_confirmation
    text = TwilioText.new
    text.send_text
    return "Thank you! Your order was placed and will be delivered before #{delivery_time}"
  end
  
  private

  def order_display
    menu = Menu.new.access_menu 
    format = ["You have ordered:"]
    @my_order.each do |item| 
      item.each do |name, quantity| 
        menu.each do |dish| 
          dish.each { |item, price| format << "#{quantity} x #{name} = £#{(quantity * price).round(2)}" if name == item }
        end
      end
    end
   puts format.join("\n")
  end

  def order_total
    sum = 0
    menu = Menu.new.access_menu 
    @my_order.each do |item|
      item.each do |name, quantity|
        menu.each do |dish| 
          dish.each { |item, price| sum += (price * quantity) if name == item } 
        end
      end
    end
    sum.round(2)
  end
  
  def delivery_time
    estimate = Time.now + (60 * 60)
    estimate.strftime('%H:%M')
  end

end
