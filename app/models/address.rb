class Address < ApplicationRecord

  belongs_to :customer

  def address_code
    "〒" + postal_code + "  " + address
  end

end
