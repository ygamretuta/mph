require 'spec_helper'

describe Transaction do
  it 'checks if item is reserved by a user' do
    user = FactoryGirl.create(:user)
    item = FactoryGirl.create(:item)
    Transaction.create(seller_id:item.user.id, buyer_id:user.id, item_id:item.id)
    expect(item.is_reserved_by?(user)).to be true
  end
end