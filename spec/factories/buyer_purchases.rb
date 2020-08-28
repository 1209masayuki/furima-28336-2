FactoryBot.define do
  factory :buyer_purchase do
    postal_code   {Faker::Number.leading_zero_number(digits: 3) + "-" + Faker::Number.leading_zero_number(digits: 4)}
    prefecture_id {Faker::Number.between(from: 2, to: 48)}
    city          {Gimei.address.city.to_s}
    addresses     {Gimei.address.town.to_s}
    building      {Faker::Lorem.word}
    phone_num     {Faker::Number.leading_zero_number(digits: 11)} 
  end
end
