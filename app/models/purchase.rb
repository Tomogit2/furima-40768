class Purchase < ApplicationRecord
  belongs_to :item
  belongs_to :user
  has_one :shipping_address

  validates :item, presence: true
  validates :user, presence: true
end
