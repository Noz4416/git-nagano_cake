class Public::OrdersController < ApplicationController

  before_action :authenticate_customer!

  def new
    @order = Order.new
  end

  def create
    cart_items = current_customer.cart_items.all
    order = current_customer.orders.new(order_params)
    order.save
    cart_items.each do |cart_item|
      order_detail = OrderDetail.new
      order_detail.item_id = cart_item.item_id
      order_detail.order_id = order.id
      order_detail.amount = cart_item.amount
      order_detail.price = cart_item.item.tax_in_price
      order_detail.save
    end
    cart_items.destroy_all
    redirect_to public_orders_thanx_path
  end

  def confirm
    @order = Order.new(order_params)
    @cart_items = current_customer.cart_items
    @total = @cart_items.inject(0) {|sum, item| sum + item.sum_of_price}
    @total_payment = @total + @order.shipping_cost
    @order.payment_method = params[:order][:payment_method]
    if params[:order][:address_number] == "0"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.customer_name
    elsif params[:order][:address_number] == "1"
      @address = Address.find(params[:order][:address_id])
      @order.postal_code = @address.postal_code
      @order.address = @address.address
      @order.name = @address.name
    elsif params[:order][:address_number] == "2"
      @order.postal_code = params[:order][:postal_code]
      @order.address = params[:order][:address]
      @order.name = params[:order][:name]
    end
  end


  def thanx
  end

  def index
    @orders = Order.where(customer_id:current_customer)
  end

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
    @total = @order_details.inject(0) {|sum, item| sum + item.sum_of_price}
    @total_payment = @total + @order.shipping_cost
  end

  private

  def order_params
    params.require(:order).permit(:postal_code,:address,:name,:payment_method)
  end

end
