class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :addresses
  has_many :cart_items
  has_many :orders
  
  def active_text
    if is_active == true
      "有効会員"
    else
      "退会済み"
    end
  end  
end
