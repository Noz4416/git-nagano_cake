class Public::CustomersController < ApplicationController
  def show
    # @customer = Customer.find(params[:id])
    @customer = current_customer
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    @customer.update(customer_params)
    redirect_to public_customers_mypage_path(@customer)
  end

  def unsubscribe
    @customer = current_customer
  end

  def withdraw
    @customer = current_customer
    @customer.update(is_active: false)
    sign_out current__customer

  end

  private

  def customer_params
    params.require(:customer).permit(:is_active,:last_name,:first_name,:last_name_kana,
    :first_name_kana,:address,:postal_code,:telephone_number)
  end

end
