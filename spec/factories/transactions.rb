# == Schema Information
#
# Table name: transactions
#
#  id               :integer          not null, primary key
#  seller_id        :integer
#  buyer_id         :integer
#  item_id          :integer
#  transaction_date :date
#  created_at       :datetime
#  updated_at       :datetime
#  buyer_confirmed  :boolean          default(FALSE)
#  seller_confirmed :boolean          default(FALSE)
#  cancelled        :boolean          default(FALSE)
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :transaction do
    association :seller, factory: :user, username: 'IAMSeller'
    association :buyer, factory: :user, username: 'IAmBuyer'
    association :item
  end
end
