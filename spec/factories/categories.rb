# == Schema Information
#
# Table name: categories
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#
FactoryGirl.define do
  factory :category do
    name "Category 1"
  end
end

