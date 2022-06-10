class HomesController < ApplicationController

  before_action :autheticate_customer!, except: [:top]

  def top
  end
end
