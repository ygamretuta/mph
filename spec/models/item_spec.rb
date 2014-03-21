# == Schema Information
#
# Table name: items
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  ad_type     :string(255)
#  category_id :integer
#  user_id     :integer
#  price       :decimal(, )
#  phone       :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

require 'spec_helper'

describe Item do
  describe 'is_owned_by?' do
    it 'checks if an item is owned by a user' do
      item = FactoryGirl.create(:item)
      expect(item.is_owned_by?(item.user)).to be true
    end
  end

  describe 'is_reserved_by?' do
    it 'checks if an item is reserved by a user' do
      user = FactoryGirl.create(:user)
      item = FactoryGirl.create(:item)
      Transaction.create(seller_id:item.user.id, buyer_id:user.id, item_id:item.id)
      expect(item.is_reserved_by?(user)).to be true
    end
  end
end