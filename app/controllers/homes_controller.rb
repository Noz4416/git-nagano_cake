class HomesController < ApplicationController

  before_action :autheticate_customer!, except: [:top,:about]

  def top
    @items = Item.all
  end
end
