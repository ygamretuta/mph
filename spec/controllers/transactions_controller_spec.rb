require 'spec_helper'

describe TransactionsController do
  context 'if buyer logged in' do
    login_user
    let!(:transaction){FactoryGirl.create(:transaction, buyer:@user)}

    describe 'PUT buyer_confirm' do
      it 'updates transaction with buyer_confirm true' do
        expect_any_instance_of(Transaction).to receive(:update).with(buyer_confirmed:true)
        put :buyer_confirm, id:transaction.id
      end
    end

    describe 'GET purchases' do
      it 'assigns transactions where logged in user is buyer to @transctions' do
        get :index, {user_id:@user.id}
        expect(assigns(:transactions)).to eq([transaction])
      end
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
