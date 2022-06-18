class Public::ItemsController < ApplicationController

  before_action :authenticate_customer!, except: [:index,:show]


  def index
    # per(x)で1ページに表示したい件数設定
    @items = Item.page(params[:page]).per(6)
  end

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
  end
end
