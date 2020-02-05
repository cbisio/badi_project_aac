# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { 'user  name' }
    birth_date { '1981-10-10' }
    gender { 'Male' }
    about { ' la mare del tano quan comprava butano ' }
    created_at { '2019-10-10' }
    updated_at { '2019-10-10' }
  end
end
