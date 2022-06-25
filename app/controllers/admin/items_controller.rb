class Admin::ItemsController < ApplicationController

  before_action :authenticate_admin!

  def index
    @items = Item.page(params[:page])
  end

  def new
    @item = Item.new
    @genres = Genre.all
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to admin_item_path(@item)
    else
      flash[:notice] = "未設定の箇所があります"
      redirect_to new_admin_item_path
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @genres = Genre.all
    @item = Item.find(params[:id])
  end

  def update
    item = Item.find(params[:id])
    item.update(item_params)
    redirect_to admin_items_path
  end

  private

  def item_params
    params.require(:item).permit(:genre_id,:image,:name,:introduction,:price,:is_active)
  end

end
