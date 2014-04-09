require 'spec_helper'

describe TransactionsController do
	login_user
	let(:item){FactoryGirl.create(:item)}
	let(:transaction){Transaction.create(buyer:@user, item:item)}

	describe 'PUT buyer_confirm' do
		it 'updates transaction with buyer_confirm true' do
			expect_any_instance_of(Transaction).to receive(:update).with(buyer_confirmed:true)
			put :buyer_confirm, id:transaction.id
		end
	end

	describe 'PUT seller_confirm' do
		pending 'find way to login seller'
	end
end
