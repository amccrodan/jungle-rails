require 'rails_helper'

RSpec.describe Order, type: :model do
  describe 'After creation' do
    before :each do
      # Setup at least two products with different quantities, names, etc
      @cat1 = Category.create!(name: 'Apparel')
      @product1 = @cat1.products.create!({
        name:  'Men\'s Classy shirt',
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      })

      @product2 = @cat1.products.create!({
        name:  'Women\'s Zebra pants',
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel2.jpg'),
        quantity: 18,
        price: 124.99
      })

      # Setup at least one product that will NOT be in the order
      @product3 = @cat1.products.create!({
        name:  'Hipster Hat',
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel3.jpg'),
        quantity: 5,
        price: 34.49
      })
    end

    it 'deducts quantity from products based on their line item quantities' do
      # 1. initialize order with necessary fields (see orders_controllers, schema and model definition for what is required)
      @order = Order.new(
        email: 'test@user.com',
        total_cents: 0,
        stripe_charge_id: 1, # test value
      )
      # 2. build line items on @order
      [@product1, @product2].each do |product|
        quantity = 3
        @order.line_items.new(
          product: product,
          quantity: quantity,
          item_price: product.price,
          total_price: product.price * quantity
        )
      end
      # 3. save! the order - ie raise an exception if it fails (not expected)
      @order.save!
      # 4. reload products to have their updated quantities
      @product1.reload
      @product2.reload
      # 5. use RSpec expect syntax to assert their new quantity values
      expect(@product1.quantity).to eql(7)
      expect(@product2.quantity).to eql(15)
    end


    it 'does not deduct quantity from products that are not in the order' do
      # TODO: Implement based on hints in previous test
      @order = Order.new(
        email: 'test@user.com',
        total_cents: 0,
        stripe_charge_id: 1, # test value
      )
      # 2. build line items on @order
      [@product1, @product2].each do |product|
        quantity = 3
        @order.line_items.new(
          product: product,
          quantity: quantity,
          item_price: product.price,
          total_price: product.price * quantity
        )
      end
      # 3. save! the order - ie raise an exception if it fails (not expected)
      @order.save!
      # 4. reload products to have their updated quantities
      @product3.reload
      # 5. use RSpec expect syntax to assert their new quantity values
      expect(@product3.quantity).to eql(5)
    end
  end
end
