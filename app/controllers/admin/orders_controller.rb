class Admin::OrdersController < ApplicationController
  
  def show
    @orders = Order.find(params[:id])
    @order_details = @orders.order_details.all
    @total_price = @order_details. inject(0) {|sum, item| sum + item.sum_of_price }
  end
  
  def index
    if params[:id]
      @orders = Customer.find(params[:id]).orders.page(params[:page])
    else
      @orders = Order.page(params[:page])
    end
  end
end
