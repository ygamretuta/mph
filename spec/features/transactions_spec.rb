require 'spec_helper'

feature "Transactions" do
  let!(:user) {FactoryGirl.create(:user)}
  let!(:item) {FactoryGirl.create(:item)}

  background do
    login_as(user, scope: :user, run_callbacks:false)
  end

  scenario 'create a transaction', es:true, js:true do
    create_transaction
  end

  scenario 'confirm transaction', es:true, js:true do
    create_transaction
    first('.transaction').click_link('Confirm')
    expect(page).to have_content 'Please wait for seller confirmation.'
  end

  after(:each) do
    Warden.test_reset!
  end

  def create_transaction
    visit root_path
    fill_in 'q', with: item.name
    click_button 'Search For It Here'
    expect(page).to have_content item.name
    click_link 'Reserve'
    expect(page).to have_content item.name
    page.execute_script("$('#transaction_datepicker').val('24-07-2014')")
    click_button 'Create Transaction'
    expect(page).to have_selector(:link_or_button, 'Confirm')
  end
end