# == Schema Information
#
# Table name: items
#
#  id             :integer          not null, primary key
#  name           :string(255)
#  ad_type        :string(255)
#  category_id    :integer
#  user_id        :integer
#  phone          :string(255)
#  created_at     :datetime
#  updated_at     :datetime
#  description    :text
#  price_centavos :integer          default(0), not null
#  price_currency :string(255)      default("PHP"), not null
#  status         :string(255)
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  sequence :name do |n|
      "item_#{n}"
  end

  factory :item do
    name
    ad_type "for_sale"
    category
    user
    description Faker::Lorem.paragraph
    phone Faker::PhoneNumber.phone_number
    pictures {[FactoryGirl.create(:picture)]}
    status 'active'
  end
end
