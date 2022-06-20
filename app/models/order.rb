class Order < ApplicationRecord

  belongs_to :customer
  has_many :order_details, dependent: :destroy

  enum payment_method: {credit_card: 0, transfer: 1}

  enum status: {waiting: 0, confirmation: 1, production: 2, ready: 3, sent: 4}


  def shipping_cost
    800
  end

  def sum_of_price
    item.tax_in_price * amount
  end


  after_update do
    # 受注ステータスが入金確認になったら
    if self.status == "confirmation"
    # 自動的に製作ステータスを製作待ちに変更する
      self.order_details.each {|order_detail|order_detail.update(making_status: "waiting")}
    end
  end


end
