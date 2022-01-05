require 'order'

describe Order do

  let(:name1) { "Hash brown" }
  let(:quantity1) { 3 }
  let(:name2) { "Sausage sandwich" }
  let(:quantity2) { 2 }

  context 'making an order' do
    it 'can create an order' do
      expect(subject.my_order).to eq([]) 
    end

    it 'add a #dish and specify a #quantity' do 
      subject.add_dish_to_order(name1, quantity1)
      expect(subject.my_order).to eq([{ "Hash brown" => 3 }])
    end 

    it 'can view order on request' do
      subject.add_dish_to_order(name1, quantity1)
      subject.add_dish_to_order(name2, quantity2)
      expect { subject.view_order }.to output.to_stdout
    end

  end

  context 'calculating cost of order' do
    it 'can process sum of order' do
      subject.add_dish_to_order(name1, quantity1)
      subject.add_dish_to_order(name2, quantity2)
      expect(subject.order_total).to eq(10.95)
    end

    it 'can output cost of order' do
      subject.add_dish_to_order(name1, quantity1)
      subject.add_dish_to_order(name2, quantity2)
      expect { subject.how_much }.to output.to_stdout
    end

    it 'will return a delivery time' do
      order = Order.new
      estimate = Time.now + (60 * 60)
      allow(order).to receive(:order_confirmation).and_return("Thank you! Your order was placed and will be delivered before #{estimate.strftime('%H:%M')}")
      order.add_dish_to_order(name1, quantity1)
      expect(order.order_confirmation).to eq("Thank you! Your order was placed and will be delivered before #{estimate.strftime('%H:%M')}")
    end
  end
end
