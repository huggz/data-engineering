# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :item do
    association :merchant
    sequence(:description) { |n| "#{Faker::Lorem.word} #{n}" }
    price { (1..100).to_a.sample.to_f + [0.0, 0.5, 0.99].sample }
  end
end
