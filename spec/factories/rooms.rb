# frozen_string_literal: true

FactoryBot.define do
  factory :room do
    name { 'tst name' }
    price { 111 }
    bills_included { false }
    deposit { 0 }
    room_size { 10 }
    property_size { 100 }
    description { 'description testing' }
    latitude { 1 }
    longitude { 1 }
    num_visits { 0 }
    created_at { '2019-10-10' }
    updated_at { '2019-10-10' }
    user_id { user_id }
    address { 'nose address' }
    city_id { city_id }
    currency { "\xE2\x82\xAC" }
  end
end
