class Purchase < ApplicationRecord
  belongs_to :item
  belongs_to :user
  has_one :shipping_address
  attr_accessor :token

  validates :token, presence: true
end
