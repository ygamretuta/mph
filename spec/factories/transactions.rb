# == Schema Information
#
# Table name: transactions
#
#  id               :integer          not null, primary key
#  item_id          :integer
#  transaction_date :date
#  created_at       :datetime
#  updated_at       :datetime
#  buyer_confirmed  :boolean          default(FALSE)
#  seller_confirmed :boolean          default(FALSE)
#  cancelled        :boolean          default(FALSE)
#  buyer_id         :integer
#  seller_id        :integer
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :transaction do
    association :buyer, factory: :user
    association :seller, factory: :user
    association :item
    transaction_date Date.tomorrow
  end

  factory :old_transaction, parent: :transaction do
    created_at 6.weeks.ago
  end

  factory :awaiting_confirmation, parent: :transaction do
    buyer_confirmed true
  end

  factory :successful, parent: :transaction do
    buyer_confirmed true
    seller_confirmed true
  end
end
