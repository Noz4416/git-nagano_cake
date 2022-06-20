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
      "売切れ"
    end
  end


  def get_image(width,height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpeg')
      image.attach(io:File.open(file_path),filename: 'no_image.jpeg', content_type: 'image/jpeg')
    end
    image.variant(resize_to_limit:[width,height]).processed
  end
end
