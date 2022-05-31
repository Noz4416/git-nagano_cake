class Admin::ItemsController < ApplicationController
  def index
  end

  def new
    @item = Item.new
  end
  
  def create
    item = Item.new(params_item)
    item.save
    redirect_to new_admin_items_path
  end

  def show
  end

  def edit
  end
end
