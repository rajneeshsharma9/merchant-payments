FactoryBot.define do
  factory :merchant, class: Merchant do
    name { |n| FFaker::Lorem.word + "#{n}" }
    description { 'Dummy body' }
    active { true }
    email { |n| FFaker::Lorem.word + "#{n}" }
    total_transaction_sum { 0.0 }
  end
end
