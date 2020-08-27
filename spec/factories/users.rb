FactoryBot.define do
  factory :user do
    nickname              {Faker::Internet.username(specifier: 1..40)}
    email                 {Faker::Internet.free_email}
    password              {Faker::Internet.password(min_length: 6, mix_case: true)}
    password_confirmation {password}
    first_name            {Gimei.last.kanji}
    last_name             {Gimei.first.kanji}
    first_name_kana       {Gimei.last.katakana}
    last_name_kana        {Gimei.first.katakana}
    birth_date            {Faker::Date.birthday(min_age: 5, max_age: 100)}
  end
end
