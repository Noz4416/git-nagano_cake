class OrderDetail < ApplicationRecord

    belongs_to :item
    belongs_to :order

    enum making_status: {impossible: 0, waiting: 1, production: 2, complete: 3}

    def tax_in_price
      (price * 1.1).floor
    end


    def sum_of_price
      tax_in_price * amount
    end


    after_update do
      order_details = self.order.order_details
      # 条件分岐:製作ステータスが1つでも製作中になったら
      if order_details.any? {|order_detail|order_detail.making_status == "production"} == true
      # 自動的に受注ステータスを製作中に変更する
        self.order.update(status: "production")
      # 条件分岐:製作ステータスが全て製作完了だったら
      elsif order_details.all?{|order_detail|order_detail.making_status == "complete"} == true
      # 自動的に受注ステータスを発送準備中に変更する
        self.order.update(status: "ready")
      end
    end

    validates :amount, presence: true

end
