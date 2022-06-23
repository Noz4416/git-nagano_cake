class Admin::CustomersController < ApplicationController

  before_action :authenticate_admin!

  def index
    @customers = Customer.page(params[:page])
  end

  def show
    @customer = Customer.find(params[:id])
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    customer = Customer.find(params[:id])
    customer.update(customer_params)
    redirect_to admin_customers_path
  end

  def orders_index
    @customer = Customer.find(params[:id])
    @orders = Order.where(customer_id:@customer).page(params[:page]).per(6).order(created_at: :desc)
  end

  private

  def customer_params
    params.require(:customer)
    .permit(:first_name,:last_name,:first_name_kana,:last_name_kana,:postal_code,
    :address,:telephone_number,:email,:is_active)
  end
end
