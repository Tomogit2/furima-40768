FactoryBot.define do
  factory :item do
    title { "Sample Item1" }
    description { "This is a sample item1." }    

    category_id { 2 }
    condition_id { 2 }
    shipping_fee_bearer_id { 2 }
    prefecture_id { 2 }
    shipping_delivery_time_id { 2 }
    price { Faker::Number.between(from: 300, to: 9_999_999) }
    association :user

    after(:build) do |item|
      item.item_image.attach(io: File.open(Rails.root.join('spec', 'fixtures', 'Sample.jpg')), filename: 'Sample.jpg', content_type: 'image/jpeg')
    end
  end
end



