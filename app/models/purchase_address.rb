class PurchaseAddress
  include ActiveModel::Model
  attr_accessor :item_id, :user_id, :zip_code, :prefecture_id, :municipalities, :street_address, :building_name,
                :telephone_number, :token

  with_options presence: true do
    validates :item_id, :user_id, :token, :municipalities, :street_address
    validates :zip_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'is invalid. Include hyphen(-)' }
    validates :telephone_number, format: { with: /\A\d{10,11}\z/, message: 'is invalid. not Include hyphen(-)' }
  end
  validates :prefecture_id, numericality: { other_than: 0, message: "can't be blank" }

  def save
    return false unless valid?
    purchase = Purchase.create(item_id: item_id, user_id: user_id)
    if purchase.persisted?
      ShippingAddress.create(zip_code: zip_code, prefecture_id: prefecture_id, municipalities: municipalities,
                             street_address: street_address, building_name: building_name, telephone_number: telephone_number, purchase_id: purchase.id)
      true
    else
      Rails.logger.error "Failed to create Purchase: #{purchase.errors.full_messages.join(", ")}"
      false
    end

=begin
    purchase = Purchase.create(item_id:, user_id:)
    ShippingAddress.create(zip_code:, prefecture_id:, municipalities:,
                           street_address:, building_name:, telephone_number:, purchase_id: purchase.id)
    true
=end
  end
end
