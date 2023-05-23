FactoryBot.define do
  factory :item do
    item_name { Faker::Commerce.product_name}
    item_text { Faker::Lorem.paragraph }
    category_id { Faker::Number.between(from: 2, to: 11) }
    delivery_area_id { Faker::Number.between(from: 2, to: 48) }
    delivery_charge_id { Faker::Number.between(from: 2, to: 3) }
    delivery_time_id { Faker::Number.between(from: 2, to: 4) }
    item_status_id { Faker::Number.between(from: 2, to: 7) }
    price { Faker::Number.between(from: 300, to: 9_999_999) }
    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end