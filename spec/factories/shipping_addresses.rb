FactoryBot.define do
  factory :shipping_address do
    zip_code { "MyString" }
    prefecture_id { 1 }
    municipalities { "MyString" }
    street_address { "MyString" }
    building_name { "MyString" }
    telephone_number { "MyString" }
    purchase { nil }
  end
end
