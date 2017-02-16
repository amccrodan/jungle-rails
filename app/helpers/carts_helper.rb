module CartsHelper

  def cart_is_empty?(cart)
    cart.size == 0
  end

end
