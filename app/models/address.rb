class Address < ApplicationRecord

  validates :last_name, presence: true
  validates :first_name, presence: true
  # 郵便番号バリデーション、ハイフン無し7桁
  validates :postal_code, presence: true, format: {with: /\A\d{7}\z/ }
  validates :address, presence: true


  belongs_to :customer

  def address_code
    "〒" + postal_code + "  " + address + "  " + name
  end

end
