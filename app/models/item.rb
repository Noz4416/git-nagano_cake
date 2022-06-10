class Item < ApplicationRecord

  has_one_attached :image

  belongs_to :genre
  has_many :cart_items, dependent: :destroy
  has_many :order_details


  def tax_in_price
    (price * 1.1).floor
  end


  def status_text
    if is_active == true
      "販売中"
    else
      "販売停止中"
    end
  end
end
