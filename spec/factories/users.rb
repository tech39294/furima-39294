Faker::Config.locale = :ja

FactoryBot.define do
  factory :user do
    nickname              { Faker::Name.name }
    email                 { Faker::Internet.free_email }
    password              { "1a#{Faker::Internet.password(min_length: 4)}" }
    password_confirmation { password }
    familyname            { Faker::Name.last_name }
    firstname             { Faker::Name.first_name }
    familyname_kana       { 'タナカ' }
    firstname_kana        { 'シンジ' }
    birth_date            { Faker::Date.between(from: '1930-01-01', to: '2018-12-31') }
  end
end
