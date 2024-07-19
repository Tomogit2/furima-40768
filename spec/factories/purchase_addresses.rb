FactoryBot.define do
  factory :purchase_address do
    token { 'tok_abcdefghijk00000000000000000' }

    zip_code { "#{Faker::Number.number(digits: 3)}-#{Faker::Number.number(digits: 4)}" }
    prefecture_id { Faker::Number.between(from: 1, to: 47) }
    municipalities { Faker::Address.city }
    street_address { Faker::Address.street_address }
    building_name { Faker::Address.secondary_address }
    telephone_number { Faker::Number.number(digits: Faker::Number.between(from: 10, to: 11)) }
  end
end
