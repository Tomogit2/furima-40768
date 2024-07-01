FactoryBot.define do
  factory :user do
    nickname { Faker::Name.name }
    email { Faker::Internet.email }
    password { Faker::Internet.password(min_length: 6) +'1a'}
    password_confirmation { password }
    lastname { Faker::Name.last_name }
    firstname { Faker::Name.first_name }
    lastname_kana { 'ヤマダ' }
    firstname_kana { 'タロウ' }
    birthday { Faker::Date.birthday }
  end
end
