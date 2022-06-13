class Public::CartItemsController < ApplicationController
  def index
    @cart_items = current_customer.cart_items.all
    @total = @cart_items.inject(0) {|sum, item| sum + item.sum_of_price}
  end

  def create
    @cart_item = CartItem.new(cart_item_params)
    @cart_item.customer_id = current_customer.id
    @cart_item.save
    redirect_to public_cart_items_path
  end



  private

  def cart_item_params
    params.require(:cart_item).permit(:customer_id,:item_id,:amount)
  end


end
