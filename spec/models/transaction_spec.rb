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

require 'spec_helper'

describe Transaction do
  let(:successful){FactoryGirl.create(:successful)}
  describe 'successful?' do
    it 'checks if transaction is confirmed by both parties' do
      expect(successful.successful?).to be true
    end
  end

  describe 'self.cleanup' do
    it 'destroys all transactions more than 30 days' do
      transaction = FactoryGirl.create(:old_transaction)
      Transaction.cleanup
      expect(transaction).not_to exist_in_database
    end
  end

  describe 'awaiting_confirmation?' do
    let(:transaction){FactoryGirl.create(:awaiting_confirmation)}

    it 'checks if transaction is awaiting confirmation' do
      expect(transaction.awaiting_confirmation?).to be true
    end
  end

  describe 'mark_as_sold_if successful' do
    it 'marks item as sold if transaction is successful' do
      expect(successful.item.sold?).to be true
    end
  end
end
