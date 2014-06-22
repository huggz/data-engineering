# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :purchase do
    association :purchaser
    association :item
    quantity { (1..10).to_a.sample }
  end
end
