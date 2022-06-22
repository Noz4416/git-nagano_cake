class Admin::OrdersController < ApplicationController

  before_action :authenticate_admin!


  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details.all
    @total_price = @order_details. inject(0) {|sum, item| sum + item.sum_of_price }
  end

  def index
    # order(created_at: :desc)で、新規注文順の表示
    @orders = Order.page(params[:page]).per(6).order(created_at: :desc)
    # 古い注文順の場合は、order(created_at: :asc)
  end

  # 受注ステータスupdate
  def order_status_update
    order = Order.find(params[:id])
    order.update(order_params)
    # OrderModel: after_update => 受注ステータス自動更新
    redirect_to admin_order_path(order)
  end

  # 製造ステータスupdate
  def making_status_update
    order_detail = OrderDetail.find(params[:id])
    order_detail.update(order_detail_params)
    # OrderDetailModel: after_update => 受注ステータス自動更新
    redirect_to admin_order_path(order_detail.order_id)
  end


  private

  def order_params
    params.require(:order).permit(:status)
  end

  def order_detail_params
    params.require(:order_detail).permit(:making_status)
  end


end
