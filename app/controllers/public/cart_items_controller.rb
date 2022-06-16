class Public::CartItemsController < ApplicationController
  def index
    @cart_items = current_customer.cart_items.all
    @total = @cart_items.inject(0) {|sum, item| sum + item.sum_of_price}
  end

  def destroy_all
    # ログイン中のカスタマーのカートを全消去
    current_customer.cart_items.destroy_all
    redirect_to public_cart_items_path
  end

  def create
    cart_item = CartItem.new(cart_item_params)
    cart_item.customer_id = current_customer.id
    # 同一商品があれば、個数を追加する。to_iは文字列を整数に変換
    if cart_item = current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id])
      cart_item.amount += params[:cart_item][:amount].to_i
      cart_item.save
      redirect_to public_cart_items_path
    else
      flash[:alert] = '数量を入力してください。'
      redirect_to public_item_path(cart_item.item_id)
    end
  end

  def destroy
    cart_item = CartItem.find(params[:id])
    cart_item.customer_id = current_customer.id
    cart_item.destroy
    redirect_to public_cart_items_path
  end

  def update
    cart_item = CartItem.find(params[:id])
    cart_item.customer_id = current_customer.id
    cart_item.update(cart_item_params)
    redirect_to public_cart_items_path
  end



  private

  def cart_item_params
    params.require(:cart_item).permit(:customer_id,:item_id,:amount)
  end


end
