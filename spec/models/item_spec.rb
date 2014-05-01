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
#  description :text
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
      transaction = FactoryGirl.create(:transaction, buyer:user)
      expect(transaction.item.is_reserved_by?(user)).to be true
    end
  end
  
  describe 'is_reserved?' do
    it 'checks if an item is reserved by anyone' do
      transaction = FactoryGirl.create(:transaction)
      expect(transaction.item.is_reserved?).to be true
    end

    it 'checks if an item is not yet reserved' do
      item = FactoryGirl.create(:item)
      expect(item.is_reserved?).to be false
    end
  end

  describe 'sold?' do
    it 'checks if an item is sold' do
      transaction = FactoryGirl.create(:successful)
      expect(transaction.item.sold?).to be true
    end

    it 'checks if an item is not sold' do
      transaction = FactoryGirl.create(:transaction)
      expect(transaction.item.sold?).to be false
    end
  end

  describe 'can_be_reserved_by?' do
    it 'checks if an item can be reserved if newly created' do
      user = FactoryGirl.create(:user)
      item = FactoryGirl.create(:item)
      expect(item.can_be_reserved_by?(user)).to be true
    end

    it 'checks if an item cannot be reserved if already reserved' do
      user = FactoryGirl.create(:user)
      transaction = FactoryGirl.create(:transaction)
      expect(transaction.item.can_be_reserved_by?(user)).to be false
    end

    it 'checks if an item cannot be reserved by its seller' do
      transaction = FactoryGirl.create(:transaction)
      user = transaction.seller
      expect(transaction.item.can_be_reserved_by?(user)).to be false
    end
  end

  describe 'assign_default_category' do
    it 'assigns default category' do
      category = FactoryGirl.create(:category)
      item = FactoryGirl.create(:item, category:nil)
      expect(item.category).to eq(category)
    end
  end
end
