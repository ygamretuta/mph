# == Schema Information
#
# Table name: pictures
#
#  id         :integer          not null, primary key
#  item_id    :integer
#  path       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :picture do
    path "image_url"
  end
end
