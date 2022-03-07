FactoryBot.define do
  factory :charge, class: Charge do
    uuid { |n| FFaker::Lorem.word + "#{n}" }
    customer_email { |n| FFaker::Lorem.word + "#{n}" }
    customer_phone { |n| FFaker::Lorem.word + "#{n}" }
    amount { 0.0 }
    status { 'approved' }
    type { 'charge' }
    merchant
  end
end
