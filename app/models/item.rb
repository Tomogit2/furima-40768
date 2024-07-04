class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :item_image

  validates :title, :description, :category_id, :condition_id, :shipping_fee_bearer_id, :prefecture_id, :shipping_delivery_time_id, :price, presence: true
  validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999 }

end
