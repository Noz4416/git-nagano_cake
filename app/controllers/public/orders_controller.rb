class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
  end

  def confirm
    @order = Order.new(order_params)
    @total = @cart_items.inject(0) {|sum, item| sum + item.sum_of_price}
    @total_payment = @total + @ordershipping_cost
  end

  def thanx
  end

  def index
  end

  def show
  end

  private

  def order_params
    params.require(:order).permit(:postal_code,:address,:name,:payment_method)
  end

end
