class OrderDetail < ApplicationRecord

    belongs_to :item
    belongs_to :order

　　enum making_status: {impossible: 0, waiting: 1,production: 2,complete: 3}

　　def tax_in_price
　　  (price * 1.1).floor
　　end

　　def sum_of_price
　　  tax_in_price * amount
　　end

    validates :amount, presence: true

end
