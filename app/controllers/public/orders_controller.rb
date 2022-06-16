class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
  end

  def create

  end

  def confirm
    @order = Order.new(order_params)
    @cart_items = current_customer.cart_items.all
    @total = @cart_items.inject(0) {|sum, item| sum + item.sum_of_price}
    @total_payment = @total + @order.shipping_cost
    session[:payment_method] = @order.payment_method
    session[:address_number] = params[:address_number]

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
