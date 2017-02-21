def cart_total
  total = 0
  cart.each do |product_id, details|
    if p = Product.find_by(id: product_id)
      total += p.price_cents * details['quantity'].to_i
    end
  end
  total
end