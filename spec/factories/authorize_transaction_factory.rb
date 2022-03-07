FactoryBot.define do
  factory :authorize_transaction, class: AuthorizeTransaction do
    uuid { |n| FFaker::Lorem.word + "#{n}" }
    customer_email { |n| FFaker::Lorem.word + "#{n}" }
    customer_phone { |n| FFaker::Lorem.word + "#{n}" }
    amount { 0.0 }
    status { 'approved' }
    type { 'authorize_transaction' }
    merchant
  end
end
