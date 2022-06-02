class Item < ApplicationRecord
  has_one_attached :image
  
  belongs_to :genre
  has_many :cart_items
  has_many :order_details
  
  def status_text
    if is_active == true
      "販売中"
    else
      "販売停止中"
    end
  end
end
