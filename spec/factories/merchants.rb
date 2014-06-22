# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :merchant do
    sequence(:name) { |n| "#{Faker::Business.name} #{n}" }
    address { Faker::Address.street_address }

    trait :with_items do
      after(:build) { |merchant| merchant.items = build_list :item, 2 }
    end
  end
end
