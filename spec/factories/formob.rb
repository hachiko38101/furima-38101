FactoryBot.define do
  factory :formob do
    post_code       { Faker::Lorem.characters(number: 3, min_numeric: 3) + "-" + Faker::Lorem.characters(number: 4, min_numeric: 4)}
    prefecture_id   { Faker::Number.within(range: 2..48) }
    city            { Faker::Address.city }
    street_address  { Faker::Address.street_address }
    building        { Faker::Lorem.word }
    phone_number    { "0" + Faker::Lorem.characters(number: 10, min_numeric: 10)}
    token           {"tok_abcdefghijk00000000000000000"}
  end
end