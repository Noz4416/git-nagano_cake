class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
  end

  def create

  end

  def confirm
    @order = Order.new(order_params)
    @cart_items = current_customer.cart_items
    @total = @cart_items.inject(0) {|sum, item| sum + item.sum_of_price}
    @total_payment = @total + @order.shipping_cost
    @order.payment_method = params[:order][:payment_method]
    if params[:order][:address_number] == "1"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.customer_name
    elsif params[:order][:address_number] == "2"
      @addresses = params[:order][:address_id]
      @address = Address.find(@addresses)
      @order.postal_code = @address.postal_code
      @order.address = @address.address
      @order.name = @address.name
    elsif params[:order][:address_number] == "3"
      @order.postal_code = params[:order][:postal_code]
      @order.address = params[:order][:address]
      @order.name = params[:order][:name]
    end
  end



  def thanx
  end

  def index
    @order.customer_id = current_customer.id
    @order = Order.all
  end

  def show
    @order = Order.find(params[:id])
    @order_details = Order.order_details
  end

  private

  def order_params
    params.require(:order).permit(:postal_code,:address,:name,:payment_method)
  end

end
