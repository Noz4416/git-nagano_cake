class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :addresses, dependent: :destroy
  has_many :cart_items, dependent: :destroy
  has_many :orders, dependent: :destroy

  def customer_address
    "〒" + postal_code + "  " + address
  end

  def customer_name
    last_name + first_name
  end

  def active_text
    if is_active == true
      "有効会員"
    else
      "退会済み"
    end
  end
end
