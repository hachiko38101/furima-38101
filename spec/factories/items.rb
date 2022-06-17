FactoryBot.define do
  factory :item do
    name                 { Faker::Lorem.word }
    explanation          { Faker::Lorem.sentence }
    price                { Faker::Number.within(range: 300..9999999) }
    condition_id         { Faker::Number.within(range: 2..7) }
    delivery_charge_id   { Faker::Number.within(range: 2..3) }
    prefecture_id        { Faker::Number.within(range: 2..48) }
    shipping_day_id      { Faker::Number.within(range: 2..4) }
    category_id          { Faker::Number.within(range: 2..11) }
    association :user

    after(:build) do |message|
      message.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
