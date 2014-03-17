# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :transaction do
    association :seller, factory: :user, username: 'IAMSeller'
    association :buyer, factory: :user, username: 'IAmBuyer'
    association :item
  end
end