FactoryBot.define do
  factory :user do
    transient do
      person{Gimei.name}
    end
    nickname              {Faker::Name.initials}
    email                 {Faker::Internet.free_email}
    password              { Faker::Lorem.characters(number: 6, min_alpha: 1, min_numeric: 1) }
    password_confirmation {password}
    first_name_kanji      {person.first.kanji}
    last_name_kanji       {person.last.kanji}
    first_name_kana       {person.first.katakana}
    last_name_kana        {person.last.katakana}
    birth_day             {Faker::Date.between(from: '1930-01-01', to: 5.years.ago)}
  end
end