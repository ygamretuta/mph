require 'spec_helper'

describe TransactionsController do

  def valid_attributes
    FactoryGirl.attributes_for(:transaction)
  end

  context 'if buyer logged in' do
    login_user
    let!(:transaction){FactoryGirl.create(:transaction, buyer:@user)}


    describe 'POST create' do
      it 'sends notification if a transaction is created' do
        # transaction was created with the let block so just check if a notification exists
        expect(Notification.count).to eq(1)
      end
    end

    describe 'PUT buyer_confirm' do
      it 'updates transaction with buyer_confirm true' do
        expect_any_instance_of(Transaction).to receive(:update).with(buyer_confirmed:true)
        put :buyer_confirm, id:transaction.id
      end
    end

    describe 'GET purchases' do
    end
  end

  context 'if seller logged in' do
    login_seller

    describe 'PUT seller_confirm' do
      it 'updates transaction with seller_confirm true' do
        expect_any_instance_of(Transaction).to receive(:update).with(seller_confirmed:true)
        put :seller_confirm, id:@transaction.id
      end
    end
  end
end
