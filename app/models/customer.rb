class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :last_name, presence: true
  validates :last_name, presence: true
  validates :first_name_kana, presence: true, format: {with: /\A[ァ-ヶー－]+\z/ }
  validates :first_name_kana, presence: true, format: {with: /\A[ァ-ヶー－]+\z/ }
  validates :telephone_number, presence: true, format: {with: /\A\d{10,11}\z/ }
  validates :postal_code, presence: true, format: {with: /\A\d{7}\z/ }
  validates :address, presence: true



  has_many :addresses, dependent: :destroy
  has_many :cart_items, dependent: :destroy
  has_many :orders, dependent: :destroy

  def active_for_authentication?
    super && (is_active == true)
  end

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
