# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :purchaser do
    sequence(:name) { |n| "#{Faker::Name.name} #{n}" }
  end
end
