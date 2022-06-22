# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController

  before_action :customer_state, only: [:create]


  def after_sign_in_path_for(resource)
    root_path
  end


  def after_sign_out_path_for(resource)
    root_path
  end

  protected

  # 退会しているかを判断するメソッド
  def customer_state
  #.処理1、入力されたemailからアカウント1件取得
    @customer = Customer.find_by(email: params[:customer][:email])
  # アカウントを取得出来なければ、メソッドを終了
    return if !@customer
  # 処理2、取得したアカウントのパスワードと入力されたものが正しいか判別
    if @customer.valid_password?(params[:customer][:password]) && !@customer.is_active
      flash[:notice] = "退会済みです。再度ご登録してご利用下さい。"
      redirect_to new_customer_registration_path
    end
  end






  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
