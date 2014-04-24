# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  username               :string(255)
#  sash_id                :integer
#  level                  :integer          default(0)
#  provider               :string(255)
#  uid                    :string(255)
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  allowed_ads_today      :integer          default(2)
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  sequence :username do |n|
    "username_#{n}"
  end
  factory :user do
    username
    email{Faker::Internet.email}
    password 'password'
    password_confirmation 'password'
    confirmed_at Time.now
    allowed_ads_today 2
  end
end
