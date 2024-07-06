class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :item_image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category, condition, shipping_fee_bearer

  validates :title, :description, :category_id, :condition_id, :shipping_fee_bearer_id, :prefecture_id, :shipping_delivery_time_id, :price, presence: true
  validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999 }
  validates :category_id, numericality: { other_than: 1 , message: "can't be blank"}
  validates :condition_id, numericality: { other_than: 1 , message: "can't be blank"}
  validates :shipping_fee_bearer_id, numericality: { other_than: 1 , message: "can't be blank"}
  validates :prefecture_id, numericality: { other_than: 1 , message: "can't be blank"}
  validates :shipping_delivery_time_id, numericality: { other_than: 1 , message: "can't be blank"}
end
