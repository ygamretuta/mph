# == Schema Information
#
# Table name: pointers
#
#  id         :integer          not null, primary key
#  value      :string(255)
#  item_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :pointer do
    value "MyString"
  end
end
