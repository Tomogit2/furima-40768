class ShippingAddress < ApplicationRecord
  belongs_to :purchase

  validates :zip_code, presence: true
  validates :prefecture_id, presence: true
  validates :municipalities, presence: true
  validates :street_address, presence: true
  validates :telephone_number, presence: true
end
